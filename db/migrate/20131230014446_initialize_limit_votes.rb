class InitializeLimitVotes < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("UPDATE `studies` SET limit_votes=0")
  end

  def down
  end
end
