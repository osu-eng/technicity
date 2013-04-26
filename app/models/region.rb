
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


  has_many :locations
  has_many :region_set_memberships
  has_many :region_sets, :through => :region_set_memberships
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


end
