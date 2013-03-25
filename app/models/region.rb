class Region < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged

  attr_accessible :name, :public, :slug, :user_id

  has_many :locations

  has_many :region_sets, :through => :region_set_memberships
  belongs_to :user

end
