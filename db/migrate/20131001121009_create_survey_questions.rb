class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.integer :survey_id
      t.string :name
      t.text :description
      t.integer :order_by

      t.timestamps
    end
  end
end
