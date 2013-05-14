class AddComparisonsCountToStudies < ActiveRecord::Migration
  def change
    add_column :studies, :comparisons_count, :integer, :default => 0
    Study.find_each do |study|
      study.update_attribute(:comparisons_count, study.comparisons.length)
      study.save
    end
  end
end
