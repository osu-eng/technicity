class Location < ActiveRecord::Base
  attr_accessible :heading, :latitude, :longitude, :pitch, :region_id
  belongs_to :region
end
