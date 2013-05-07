class AddPromotedToStudy < ActiveRecord::Migration
  def change
    add_column :studies, :promoted, :boolean, :default => false
  end

  def down
  end
end
