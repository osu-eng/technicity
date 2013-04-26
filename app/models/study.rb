
class StudyLaunchValidator < ActiveModel::Validator

  def validate(study)
    # These conditions really only apply if a study is opening
    if study.active

      if study.region_set.nil?
        study.errors[:base] << 'A study must have one image set'

      else

        if study.opened_at.nil?
          study.errors[:base] << 'A open study must have an "opened at" date'
        end

        if study.region_set.regions.length < 1
          study.errors[:base] << 'A study\'s image set must have at least one area'
        end

        study.region_set.regions.each do |region|
          if region.locations.length < 2
            study.errors[:base] << 'Each area must have at least two images'
          end
        end
      end

    end
  end
end

class Study < ActiveRecord::Base

  include ActiveModel::Validations
  validates_with StudyLaunchValidator

  extend FriendlyId
  friendly_id :name, use: :slugged
  validates_presence_of :name, :slug, :question, :description, :user_id

  attr_accessible :name, :public, :question, :description, :slug, :user_id, :active

  belongs_to :region_set
  belongs_to :user
  has_many :comparisons

end


