class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.integer :survey_id
      t.string :name
      t.text :description
      t.boolean :multiple_choice
      t.integer :order_by

      t.timestamps
    end
    add_index :survey_questions, :survey_id
  end
end
