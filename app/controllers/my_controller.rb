class MyController < ApplicationController

  def dashboard
    @studies = My::studies
    @region_sets = My::region_sets
    @regions = My::regions

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studies }
    end
  end

  def studies
    @studies = My::studies

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studies }
    end
  end

  def regions
    @regions = My::regions

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regions }
    end
  end

  def collections
    @region_sets = My::region_sets

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @region_sets }
    end
  end
end
