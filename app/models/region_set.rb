class RegionSet < ActiveRecord::Base
  attr_accessible :name, :public, :slug, :user_id, :description

  has_many :studies
  has_many :regions, :through => :region_set_memberships
  has_many :region_set_memberships
  belongs_to :user

end
