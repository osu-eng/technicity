class MyController < ApplicationController

  def dashboard
    @studies = My::studies
    @regions = Region.all
    @region_sets = RegionSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studies }
    end
  end

  def studies
    @studies = Study.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studies }
    end
  end
end
