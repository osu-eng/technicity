class AddOpenCloseDatesToStudy < ActiveRecord::Migration
  def change
    # These record when a study is most recently opened or closed
    add_column :studies, :opened_at, :datetime
    add_column :studies, :closed_at, :datetime
  end
end
