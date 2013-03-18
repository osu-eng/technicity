class RegionSet < ActiveRecord::Base
  attr_accessible :name, :public, :slug, :user_id

  belongs_to :study
end
