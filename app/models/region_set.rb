class RegionSet < ActiveRecord::Base
  attr_accessible :name, :public, :slug, :user_id, :description

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  include ActiveModel::Validations
  validates_presence_of :name, :description, :user_id

  has_many :studies

  has_many :regions, :through => :region_set_memberships, :dependent => :destroy
  has_many :region_set_memberships, :dependent => :destroy

  belongs_to :user

  def locked?
    locked = false
    self.studies.each do |study|
      locked = locked || !study.active.nil?
    end
    locked
  end

end
