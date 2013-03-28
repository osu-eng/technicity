class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  #attr_accessible :email, :name

  has_many :studies
  has_many :region_sets
  has_many :regions

  # This should return the uid of the current user.
  # After we get authentication in, this should be changed.
  def self.current_id
    505
  end

end
