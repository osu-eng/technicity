
class RegionValidator < ActiveModel::Validator

  def validate(region)
    if region.polygon_path.length < 3
      region.errors[:base] << 'You must click at least three points on the map to define a polygon'
    end
  end
end

class Region < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  include ActiveModel::Validations
  validates_with RegionValidator
  validates_presence_of :name, :description, :latitude, :longitude, :zoom, :polygon, :user_id, :slug

  attr_accessible :name, :public, :slug, :user_id, :description, :latitude, :longitude, :zoom, :polygon


  has_many :locations, :dependent => :destroy
  has_many :region_set_memberships
  has_many :region_sets, :through => :region_set_memberships
  has_many :chosen, :through => :locations
  has_many :rejected, :through => :locations
  belongs_to :user

  def show
    @locations = self.locations
  end

  def polygon_path
    coordinates = []
    rows = self.polygon.scan /([\d.-]+)[^\d.-]+([\d.-]+)/
    rows.each do |row|
      coordinates.push({:lat => row[0].to_f, :lng => row[1].to_f})
    end
    return coordinates
  end

  def polygon_bounds
    hash = {}
    path = self.polygon_path
    if path.length == 0
      return nil
    else
      min_lat = max_lat = path[0][:lat]
      min_lng = max_lng = path[0][:lng]
      path.each do |latlng|
        lat = latlng[:lat]
        lng = latlng[:lng]
        min_lat = (lat < min_lat) ? lat : min_lat
        max_lat = (lat > max_lat) ? lat : max_lat
        min_lng = (lng < min_lng) ? lng : min_lng
        max_lng = (lng > max_lng) ? lng : max_lng
      end
      return {
        :min_lat => min_lat,
        :max_lat => max_lat,
        :range_lat => max_lat - min_lat,
        :min_lng => min_lng,
        :max_lng => max_lng,
        :range_lng => max_lng - min_lng,
      }
    end
  end

  def heatmap(study_id)
    location_results = ActiveRecord::Base.connection.exec_query("
    SELECT l.id, l.latitude, l.longitude, cl.chosen, rl.rejected
    FROM locations l
    LEFT JOIN (
      SELECT  
        chosen_location_id as id, 
        count(*) as chosen
      FROM comparisons
      WHERE study_id = #{study_id}
      GROUP BY chosen_location_id
    ) cl on cl.id = l.id
    LEFT JOIN (
      SELECT  
        rejected_location_id as id, 
        count(*) as rejected
      FROM comparisons
      WHERE study_id = #{study_id}
      GROUP BY rejected_location_id
    ) rl on rl.id = l.id
    WHERE 
      l.region_id = #{self.id}
    ")

    region_heatmap = Hash.new
    region_heatmap['locations'] = Hash.new
    region_heatmap['max_intensity'] = 0
    location_results.each do |location|
      region_heatmap['locations'][location['id']] = {
        'latitude' => location['latitude'],
        'longitude' => location['longitude'],
        'weight' => Location.normalized(location['chosen'], location['rejected'])
      }
      region_heatmap['max_intensity'] = [ region_heatmap['max_intensity'], region_heatmap['locations'][location['id']]['weight'] ].max
    end
    region_heatmap
  end
end
