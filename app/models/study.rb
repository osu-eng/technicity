class Study < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :slug

  attr_accessible :name, :public, :question, :description, :slug, :user_id

  belongs_to :region_set
  belongs_to :user
  has_many :comparisons


  # Returns true if this is editable by the current user
  def editable?
    User::current_id == self.user_id
  end

end
