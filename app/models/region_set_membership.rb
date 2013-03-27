class RegionSetMembership < ActiveRecord::Base
  attr_accessible :region_id, :region_set_id

  belongs_to :region
  belongs_to :region_set

  # Returns true if this is editable by the current user
  def editable?
    User::current_id == self.user_id
  end
end
