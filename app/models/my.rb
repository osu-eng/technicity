class My

  def studies
    Study.includes(:comparisons, :region_sets => [:regions]).where(:user_id => User::current_id)
  end

  def regions
    Region.all
  end

  def region_sets
    RegionSets.all
  end

end
