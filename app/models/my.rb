class My
  #2013-04-01 MF - need to add this back in
  
  #def self.studies
  #  Study.includes(:comparisons, :region_set => [:regions]).where(:user_id => User::current_id)
  #end

  #def self.region_sets
  #  RegionSet.includes(:studies, :regions ).where(:user_id => User::current_id)
  #end

  #def self.regions
  #  Region.includes(:locations, :region_sets) #.where(:user_id => User::current_id)
  #end

end
