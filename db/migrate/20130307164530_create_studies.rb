class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.string :user_id
      t.string :integer
      t.string :slug
      t.string :question
      t.boolean :public

      t.timestamps
    end
  end
end
