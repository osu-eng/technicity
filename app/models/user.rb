class User < ActiveRecord::Base
  attr_accessible :email, :name

  has_many :studies
  has_many :region_sets
  has_many :regions

  # This should return the uid of the current user.
  # After we get authentication in, this should be changed.
  def self.current_id
    505
  end

end
