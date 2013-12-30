class InitializeNewStudyFields < ActiveRecord::Migration
  def up
    ActiveRecord::Base.connection.execute("UPDATE `studies` SET has_survey=0, comparisons_count=0, survey_required_votes=0")
  end

  def down
  end
end
