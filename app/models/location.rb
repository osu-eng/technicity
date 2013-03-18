class Location < ActiveRecord::Base
  attr_accessible :heading, :lattitude, :longitude, :pitch, :region_id

  belongs_to :region
end
