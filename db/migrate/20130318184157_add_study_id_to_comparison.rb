class AddStudyIdToComparison < ActiveRecord::Migration
  def change
    add_column :comparisons, :study_id, :integer
  end
end
