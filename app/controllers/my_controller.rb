class MyController < ApplicationController

  before_filter :authenticate_user!
  
  def dashboard
    @studies = Study.includes(:comparisons, :region_set => [:regions]).where(:user_id => User::current_id)
    @region_sets = RegionSet.includes(:studies, :regions ).where(:user_id => User::current_id)
    @regions = Region.includes(:locations, :region_sets) #.where(:user_id => User::current_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studies }
    end
  end

  def studies
    @studies = Study.includes(:comparisons, :region_set => [:regions]).where(:user_id => User::current_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studies }
    end
  end

  def regions
    @regions = Region.includes(:locations, :region_sets) #.where(:user_id => User::current_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regions }
    end
  end

  def imagesets
    @region_sets = RegionSet.includes(:studies, :regions ).where(:user_id => User::current_id)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @region_sets }
    end
  end
end
