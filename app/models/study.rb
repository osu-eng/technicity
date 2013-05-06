
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

  def randomLocation
    region = self.region_set.regions.offset(rand( self.region_set.regions.count)).first
    region.locations.offset(rand(region.locations.count)).first
  end

  def randomLocationPair
    location1 = self.randomLocation
    location2 = self.randomLocation

    # Some checks to make sure we get different locations
    # and a hedge against infinite loops which should not be possible
    # due to pre-launch study validation.
    i = 0
    while (location1.id == location2.id) && i < 1000
      location2 = self.randomLocation
      i += 1
    end

    [location1, location2]
  end

  def self.randomActive
    offset = rand(Study.where(:active => true).count)
    rand_record = Study.where(:active => true).first(:offset => offset)
  end

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
      IFNULL(cl.chosen, 0) + IFNULL(rl.rejected, 0) as total_votes,
      CASE
        WHEN IFNULL(cl.chosen, 0) + IFNULL(rl.rejected, 0) > 0 THEN 100 * IFNULL(cl.chosen, 0) / (IFNULL(cl.chosen, 0) + IFNULL(rl.rejected, 0))
        ELSE 0
        END as percent_chosen,
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
    result_set = ActiveRecord::Base.connection.exec_query("
      SELECT
        r.id,
        r.name,
        r.latitude,
        r.longitude,
        r.zoom,
        lc.locations,
        cl.chosen,
        rl.rejected,
        rl.cl.chosen + rl.rejected as total,
        CASE
          WHEN cl.chosen + rl.rejected > 0 THEN cl.chosen / (cl.chosen + rl.rejected)
          ELSE 0
          END as percent_favored

      FROM regions r
      JOIN region_set_memberships rsm ON rsm.region_id = r.id
      JOIN region_sets rs on rs.id = rsm.region_set_id
      JOIN studies s on s.region_set_id = rs.id
      JOIN (
        SELECT r.id, COUNT(*) as locations
        FROM regions r
        JOIN locations l on l.region_id = r.id
        JOIN region_set_memberships rsm ON rsm.region_id = r.id
        JOIN region_sets rs on rs.id = rsm.region_set_id
        JOIN studies s on s.region_set_id = rs.id
        WHERE s.id=#{self.id}
        GROUP BY r.id
        ) lc on lc.id = r.id
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

  def full_results
    Comparison.includes(:chosen_location, {:chosen_location => :region}, :rejected_location, {:rejected_location => :region}).joins(:chosen_location, {:chosen_location => :region}, :rejected_location, {:rejected_location => :region}).where(:study_id => self.id)
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

  def full_csv(options = {})
    CSV.generate(options) do |csv|
      csv << [
        'comparison_id',
        'date',
        'voter_ip',
        'voter_latitude',
        'voter_longitude',
        'study',
        'question',
        'chosen_id',
        'chosen_latitude',
        'chosen_longitude',
        'chosen_pitch',
        'chosen_heading',
        'chosen_region_name',
        'chosen_image_url',
        'rejected_id',
        'rejected_latitude',
        'rejected_longitude',
        'rejected_pitch',
        'rejected_heading',
        'rejected_region_name',
        'rejected_image_url',
      ]
      self.full_results.each do |comparison|
        #abort(comparison.to_yaml)
        csv << [
          comparison.id,
          comparison.created_at,
          comparison.voter_remote_ip,
          comparison.voter_latitude,
          comparison.voter_longitude,
          self.slug,
          self.question,
          comparison.chosen_location.id,
          comparison.chosen_location.latitude,
          comparison.chosen_location.longitude,
          comparison.chosen_location.pitch,
          comparison.chosen_location.heading,
          comparison.chosen_location.region.name,
          comparison.chosen_location.image_url,
          comparison.rejected_location.id,
          comparison.rejected_location.latitude,
          comparison.rejected_location.longitude,
          comparison.rejected_location.pitch,
          comparison.rejected_location.heading,
          comparison.rejected_location.region.name,
          comparison.rejected_location.image_url,
        ]
      end
    end
  end
end
