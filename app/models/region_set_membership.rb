class RegionSetMembership < ActiveRecord::Base
  attr_accessible :region_id, :region_set_id

  belongs_to :region
  belongs_to :region_set
end
