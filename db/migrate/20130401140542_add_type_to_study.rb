class AddTypeToStudy < ActiveRecord::Migration
  def change
    add_column :studies, :type, :string
  end
end
