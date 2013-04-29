class Location < ActiveRecord::Base
  attr_accessible :heading, :latitude, :longitude, :pitch, :region_id
  belongs_to :region

  has_many :chosen, :foreign_key => 'chosen_location_id', :class_name => 'Comparison', :dependent => :destroy
  has_many :rejected, :foreign_key => 'rejected_location_id', :class_name => 'Comparison', :dependent => :destroy
end
