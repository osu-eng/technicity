class Location < ActiveRecord::Base
  attr_accessible :heading, :lattitude, :longitude, :pitch, :region_id
end
