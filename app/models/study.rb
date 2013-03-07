class Study < ActiveRecord::Base
  attr_accessible :integer, :public, :question, :slug, :user_id
end
