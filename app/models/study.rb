class Study < ActiveRecord::Base
  attr_accessible :integer, :public, :question, :slug, :user_id

  has_one :region_set
  has_one :user

end
