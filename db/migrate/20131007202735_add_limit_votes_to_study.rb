class AddLimitVotesToStudy < ActiveRecord::Migration
  def change
    add_column :studies, :limit_votes, :boolean, default: false
  end
end
