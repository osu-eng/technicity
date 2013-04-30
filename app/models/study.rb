
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
    self.region_set.regions.each do |region|
      heatmap_collection[region.id] = region.heatmap(self.id)
    end
    heatmap_collection
  end

  def max_intensity
    self.region_set.regions.map{|region| region.max_intensity(self.id)}.max
  end

  def results
    result_set = ActiveRecord::Base.connection.execute("
    SELECT l.id, l.latitude, l.longitude, l.heading, l.pitch, cl.chosen, rl.rejected
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
end
