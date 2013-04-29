class Location < ActiveRecord::Base
  attr_accessible :heading, :latitude, :longitude, :pitch, :region_id
  belongs_to :region

  has_many :chosen, :foreign_key => 'chosen_location_id', :class_name => 'Comparison', :dependent => :destroy
  has_many :rejected, :foreign_key => 'rejected_location_id', :class_name => 'Comparison', :dependent => :destroy

  def score (study_id)
    self.chosen.where("study_id = ?", :study_id).count
  end

  def total (study_id)
    self.chosen.where("study_id = ?", :study_id).count + self.rejected.where("study_id = ?", :study_id).count
  end

  def normalized (study_id)
    self.score(:study_id).to_f / (self.total(:study_id).nonzero? || 1).to_f
  end
end
