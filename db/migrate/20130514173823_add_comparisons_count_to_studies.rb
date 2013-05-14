class AddComparisonsCountToStudies < ActiveRecord::Migration
  def change
    add_column :studies, :comparisons_count, :integer, :default => 0
    Study.find_each do |study|
      Study.reset_counters study.id, :comparisons
    end
  end
end
