class Region < ActiveRecord::Base
  attr_accessible :name, :public, :slug, :user_id
end
