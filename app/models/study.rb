
class StudyLaunchValidator < ActiveModel::Validator

  def validate(study)
    # These conditions really only apply if a study is opening
    if study.active

      if study.region_set.nil?
        study.errors[:base] << 'A study must have one image set'

      else

        if study.opened_at.nil?
          study.errors[:base] << 'A open study must have an "opened at" date'
        end

        if study.region_set.regions.length < 1
          study.errors[:base] << 'A study\'s image set must have at least one area'
        end

        study.region_set.regions.each do |region|
          if region.locations.length < 2
            study.errors[:base] << 'Each area must have at least two images'
          end
        end
      end

    end
  end
end

class Study < ActiveRecord::Base

  include ActiveModel::Validations
  validates_with StudyLaunchValidator

  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :slug, :question, :description, :user_id

  attr_accessible :name, :public, :question, :description, :slug, :user_id, :active

  belongs_to :region_set
  belongs_to :user
  has_many :comparisons, :dependent => :destroy
  has_many :regions, :through => :region_set
  has_many :locations, :through => :regions

  def heatmaps
    heatmap_collection = Hash.new
    heatmap_collection['regions'] = Hash.new
    heatmap_collection['max_intensity'] = 0
    self.region_set.regions.each do |region|
      heatmap_collection['regions'][region.id] = region.heatmap(self.id)
      heatmap_collection['max_intensity'] = [ heatmap_collection['max_intensity'], heatmap_collection['regions'][region.id]['max_intensity'] ].max
    end
    heatmap_collection
  end

  def results
    result_set = ActiveRecord::Base.connection.exec_query("
    SELECT
      l.id AS location_id,
      l.latitude,
      l.longitude,
      l.heading,
      l.pitch,
      IFNULL(cl.chosen, 0) AS chosen,
      IFNULL(rl.rejected, 0) AS rejected,
      r.name AS region_name,
      s.slug AS study,
      s.question
    FROM locations l
    LEFT JOIN (
      SELECT  
        chosen_location_id as id, 
        count(*) as chosen
      FROM comparisons
      WHERE study_id = #{self.id}
      GROUP BY chosen_location_id
    ) cl on cl.id = l.id
    LEFT JOIN (
      SELECT  
        rejected_location_id as id, 
        count(*) as rejected
      FROM comparisons
      WHERE study_id = #{self.id}
      GROUP BY rejected_location_id
    ) rl on rl.id = l.id
    LEFT JOIN regions r ON r.id = l.region_id
    LEFT JOIN studies s ON s.id = #{self.id}
    WHERE 
      l.region_id IN (
        SELECT r.id
        FROM regions r
        JOIN region_set_memberships rsm ON rsm.region_id = r.id
        JOIN region_sets rs on rs.id = rsm.region_set_id
        JOIN studies s on s.region_set_id = rs.id
        WHERE s.id = #{self.id})
    ")
    result_set
  end

  def region_results
    result_set = ActiveRecord::Base.connection.execute("
      SELECT 
        r.id,
        r.name,
        r.latitude,
        r.longitude,
        r.zoom,
        cl.chosen,
        rl.rejected
      FROM regions r
      JOIN region_set_memberships rsm ON rsm.region_id = r.id
      JOIN region_sets rs on rs.id = rsm.region_set_id
      JOIN studies s on s.region_set_id = rs.id
      LEFT JOIN (
        SELECT  
          cl.region_id,
          count(*) as chosen
        FROM comparisons c
        JOIN locations cl ON c.chosen_location_id = cl.id
        JOIN locations rl ON c.rejected_location_id = rl.id
        WHERE c.study_id = #{self.id} AND cl.region_id <> rl.region_id
        GROUP BY cl.region_id
      ) cl ON cl.region_id = r.id
      LEFT JOIN (
        SELECT  
          rl.region_id,
          count(*) as rejected
        FROM comparisons c
        LEFT JOIN locations cl ON c.chosen_location_id = cl.id
        LEFT JOIN locations rl ON c.rejected_location_id = rl.id
        WHERE c.study_id = #{self.id} AND cl.region_id <> rl.region_id
        GROUP BY rl.region_id
      ) rl ON rl.region_id = r.id
      WHERE s.id=#{self.id}
    ")
  end

  def to_csv(options = {})
    study_results = self.results
    CSV.generate(options) do |csv|
      csv << study_results.first.keys.push('image_url')
      study_results.each do |location|
        location['image_url'] = "http://maps.googleapis.com/maps/api/streetview?size=470x306&location=#{location['latitude']}%2C%20#{location['longitude']}&heading=#{location['heading']}&pitch=#{location['pitch']}&sensor=false"
        csv << location.values
      end
    end
  end
end
