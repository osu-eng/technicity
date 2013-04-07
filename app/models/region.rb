class Region < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name, :public, :slug, :user_id, :description, :latitude, :longitude, :zoom, :polygon

  has_many :locations
  has_many :region_set_memberships
  has_many :region_sets, :through => :region_set_memberships
  belongs_to :user

  def show
    @locations = self.locations
  end

  def polygon_array
    self.polygon.scan /([\d.-]+)[^\d.-]+([\d.-]+)/
  end
end
