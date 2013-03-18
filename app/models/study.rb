class Study < ActiveRecord::Base
  attr_accessible :integer, :public, :question, :slug, :user_id

  belongs_to :region_set
  belongs_to :user

end
