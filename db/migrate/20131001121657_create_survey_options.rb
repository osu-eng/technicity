class CreateSurveyOptions < ActiveRecord::Migration
  def change
    create_table :survey_options do |t|
      t.integer :survey_question_id
      t.string :name
      t.integer :order_by

      t.timestamps
    end
    add_index :survey_options, :survey_question_id
  end
end
