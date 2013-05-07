class RegionSetValidator < ActiveModel::Validator

  def validate(proposed)
    if proposed.region_set.locked?
      proposed.errors[:base] << 'You cannot add a region to a locked study'
    end
  end
end

class RegionSetMembership < ActiveRecord::Base
  include ActiveModel::Validations
  validates_with RegionSetValidator
  attr_accessible :region_id, :region_set_id

  belongs_to :region
  belongs_to :region_set

end
