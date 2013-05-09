
class LocationChangeValidator < ActiveModel::Validator

  def validate(proposed)

    if !proposed.id.nil?
      original = Location.find(proposed.id)
      if original.region != proposed.region
        proposed.errors[:region] << 'You cannot change the region of a location'
      end

      if original.region.locked?
        proposed.errors[:base] << 'You cannot change a location that is part of a study that has already been launched as this would invalidate results.'
      end

      if (proposed.pitch > 90) or proposed.pitch < -90
        proposed.errors[:pitch] << 'Pitch must be between -90 and 90 degrees'
      end

      if (proposed.heading > 360) or proposed.heading < 0
        proposed.errors[:heading] << 'Heading must be between 0 and 360 degrees'
      end

      if (proposed.latitude > 90) or proposed.latitude < -90
        proposed.errors[:latitude] << 'Latitude must be between -90 and 90 degrees'
      end

      if (proposed.longitude > 180) or proposed.longitude < -180
        proposed.errors[:longitude] << 'Longitude must be between -180 and 180 degrees'
      end

    end
  end
end

class Location < ActiveRecord::Base
  validates_with LocationChangeValidator
  attr_accessible :heading, :latitude, :longitude, :pitch, :region_id
  belongs_to :region

  has_many :chosen, :foreign_key => 'chosen_location_id', :class_name => 'Comparison', :dependent => :destroy
  has_many :rejected, :foreign_key => 'rejected_location_id', :class_name => 'Comparison', :dependent => :destroy

  def score (study_id)
    self.chosen.where("study_id = ?", study_id).count
  end

  def total (study_id)
    self.chosen.where("study_id = ?", study_id).count + self.rejected.where("study_id = ?", study_id).count
  end

  def normalized (study_id)
    Location.normalized(self.score(study_id), self.rejected.where("study_id = ?", study_id).count)
  end

  def self.normalized (chosen, rejected)
    chosen.to_f / ((chosen.to_i + rejected.to_i).nonzero? || 1).to_f
  end

  def image_url(width=470, height=306)
    "http://maps.googleapis.com/maps/api/streetview?size=" + width.to_s + "x" + height.to_s + "&location=#{self.latitude}%2C#{self.longitude}&heading=#{self.heading}&pitch=#{self.pitch}&sensor=false"
  end
end
