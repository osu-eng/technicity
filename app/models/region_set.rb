class RegionSet < ActiveRecord::Base
  attr_accessible :name, :public, :slug, :user_id

  has_many :regions, :through => :region_set_memberships
  belongs_to :user
end
