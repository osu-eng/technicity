class AddHasSurveyToStudies < ActiveRecord::Migration
  def change
    add_column :studies, :has_survey, :boolean, default: true
  end
end
