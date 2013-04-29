class StudiesController < ApplicationController
    before_filter :require_ownership, only: [ :edit, :update, :destroy, :curate ]
    before_filter :authenticate_user!, only: [ :new ]
  # GET /studies
  # GET /studies.json
  def index
    @studies = Study.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studies }
    end
  end

  # GET /studies/1
  # GET /studies/1.json
  def show
    @study = Study.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @study }
    end
  end

  # GET /studies/1/analyze
  def analyze
    @study = Study.find(params[:id])

    respond_to do |format|
      format.html # analyze.html.erb
    end
  end

  # GET /studies/1/heatmap
  # GET /studies/1.json
  def heatmap
    @study = Study.find(params[:id])
    @heatmaps = Hash.new
    @max_intensity = 0
    @study.region_set.regions.each do |region|
      @heatmaps[region.id] = Hash.new

      region.locations.each do |location|
        score = Comparison.where("study_id = ? AND chosen_location_id = ?", @study.id, location.id).count
        total = Comparison.where("study_id = ? AND (chosen_location_id = ? OR rejected_location_id = ?)", @study.id, location.id, location.id).count
        weighted = score.to_f / (total.nonzero? || 1).to_f
        @heatmaps[region.id][location.id] = {'latitude' => location.latitude, 'longitude' => location.longitude, 'weight' => weighted}
        @max_intensity = [@max_intensity, weighted].max
      end
    end

    respond_to do |format|
      format.html # heatmap.html.erb
    end
  end

  # GET /studies/1/vote
  def vote
    @study = Study.find(params[:id])

    respond_to do |format|
      format.html # vote.html.erb
    end
  end

  def status
    @study = Study.find(params[:id])
    render :partial => "studies/status"
  end

  # GET /studies/1/curate
  def curate
    # security - users should only be able to curate regions they own
    @study = Study.find(params[:id])
    @region = Region.find(params[:region_id])

    respond_to do |format|
      format.html # curate.html.erb
    end
  end

  # GET /studies/new
  # GET /studies/new.json
  def new
    @study = Study.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @study }
    end
  end

  # GET /studies/1/edit
  def edit
    @study = Study.find(params[:id])
  end

  # POST /studies
  # POST /studies.json
  def create
    @study = Study.new(params[:study])
    @study.user_id = current_user.id

    respond_to do |format|
      if @study.save

        format.html { redirect_to url_for(:controller => "regions", :action => "new") + '?study_id=' + @study.id.to_s() + '&create_set=true', notice: 'Study was successfully created.' }
        format.json { render json: @study, status: :created, location: @study }
      else
        format.html { render action: "new" }
        format.json { render json: @study.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /studies/1
  # PUT /studies/1.json
  def update
    @study = Study.find(params[:id])

    respond_to do |format|
      if @study.update_attributes(params[:study])
        format.html { redirect_to @study, notice: 'Study was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @study.errors, status: :unprocessable_entity }
      end
    end
  end

  def open
    @study = Study.find(params[:id])

    # If the study is closed or never opened
    if !@study.active

      @study.opened_at = DateTime.now()
      @study.active = true

      # Are we launching the study for the first time?
      if @study.valid?
        # lock related objects
        @study.region_set.locked = true
        @study.region_set.save
        @study.region_set.regions.each do |region|
          region.locked = true
          region.save
        end
      end


    end

    if @study.save
      respond_to do |format|
        format.html { redirect_to @study, notice: 'Study was successfully updated.' }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { render :nothing => true }
        format.json { render json: @study.errors, status: :unprocessable_entity }
      end
    end
  end

  def close
    @study = Study.find(params[:id])
    if @study.active
      @study.active = false
      @study.closed_at = DateTime.now()
      @study.save
    end

    respond_to do |format|
      format.html { redirect_to @study, notice: 'Study was successfully updated.' }
      format.json { head :no_content }
    end
  end

  # DELETE /studies/1
  # DELETE /studies/1.json
  def destroy
    @study = Study.find(params[:id])
    @study.destroy

    respond_to do |format|
      format.html { redirect_to studies_url }
      format.json { head :no_content }
    end
  end

  private
  #authorization
  def require_ownership
    @study = require_model_ownership(Study)
  end


end
