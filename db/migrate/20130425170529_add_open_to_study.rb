class AddOpenToStudy < ActiveRecord::Migration
  def change
    add_column :studies, :active, :boolean
  end
end
