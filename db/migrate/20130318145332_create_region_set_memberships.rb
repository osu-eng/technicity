class CreateRegionSetMemberships < ActiveRecord::Migration
  def change
    create_table :region_set_memberships do |t|
      t.integer :region_set_id
      t.integer :region_id

      t.timestamps
    end
  end
end
