class User < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :studies
  has_many :region_sets
  has_many :region_sets

end
