class AddRegionSetIdToStudy < ActiveRecord::Migration
  def change
    add_column :studies, :region_set_id, :integer
  end
end
