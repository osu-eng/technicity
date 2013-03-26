class MyController < ActionController::Base

  def index
    @studies = Study.all
    @regions = Region.all

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
