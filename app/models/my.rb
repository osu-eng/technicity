class My

  def self.studies
    Study.includes(:comparisons, :region_set => [:regions]).where(:user_id => User::current_id)
  end

  def self.regions
    Region.all
  end

  def self.region_sets
    RegionSets.all
  end

end
