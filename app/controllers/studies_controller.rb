class StudiesController < ApplicationController

  require 'will_paginate/array'

  before_filter :authenticate_user!, only: [ :new, :edit, :update, :destroy, :curate, :open, :close, :mine ]
  before_filter :require_can_edit, only: [ :edit, :update, :destroy, :curate, :open, :close, :destroybadvotes ]
  before_filter :require_can_view_results, only: [ :results, :region_results, :heatmap, :download ]

  handles_sortable_columns

  # GET /studies
  # GET /studies.json
  def index
    order = sortable_column_order
    @studies = Study.search(params[:q]).where('region_set_id IS NOT NULL AND region_set_id <> "" AND active IS NOT NULL AND active <> ""').order(order).paginate(:page => params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @studies }
    end
  end

  def mine
    # You should only be able to see your own study listings unless you are an admin
    if !(!current_user.nil? and (current_user.admin or (params[:user_id] == current_user.id.to_s)))
      trigger_403('You do not have permission to access the studies of that user.')
    else
      order = sortable_column_order
      @studies = Study.where("user_id = ? AND region_set_id IS NOT NULL", params[:user_id]).order(order).paginate(:page => params[:page])
      @mine = true
      respond_to do |format|
        if @studies.nil?
          format.html { redirect_to studies_url, notice: 'You have not yet created any studies.' }
          # MF - not sure what json should be here
          format.json { head :no_content }
        else
          format.html # mine.html.erb
          format.json { render json: @studies }
        end
      end
    end
  end

  # GET /studies/1
  # GET /studies/1.json
  def show
    @study = Study.find(params[:id])

    redirect_to :action => :vote, :id => @study, status: :moved_permanently
  end

  # GET /studies/1/results
  # GET /studies/1/results.json
  # GET /studies/1/results.csv
  # GET /studies/1/results.xls
  def results
    @study = Study.find(params[:id])
    if url_for() != url_for(:id => @study)
      return redirect_to :id => @study, status: :moved_permanently
    end

    @results = @study.results.to_a
    logger.debug(@results)
    sortable_column_order do |column, direction|
      case column
      when 'latitude', 'longitude', 'chosen', 'rejected', 'region_name', 'study', 'total_votes', 'percent_chosen'
        if direction.to_s == 'asc'
          @results.sort! {|a,b| a[column] <=> b[column]}
        else
          @results.sort! {|a,b| b[column] <=> a[column]}
        end
      else
          @results.sort! {|a,b| b['percent_chosen'] <=> a['percent_chosen']}
      end
    end

    page = params[:page].nil? ? 1 : params[:page]
    per_page = 25
    @page_results = @results.paginate(:page => page, :per_page => per_page)

    respond_to do |format|
      format.html # results.html.erb
      format.json { render json: @study.results }
      format.csv { send_data @study.to_csv }
      format.xls { send_data @study.to_csv(col_sep: "\t") }
    end
  end

  # GET /studies/1/full_results.json
  # GET /studies/1/full_results.csv
  # GET /studies/1/full_results.xls
  def full_results
    @study = Study.find(params[:id])

    respond_to do |format|
      format.json { render json: @study.full_results }
      format.csv { send_data @study.full_csv }
      format.xls { send_data @study.full_csv(col_sep: "\t") }
    end
  end

  # GET /studies/1/region_results
  def region_results
    @study = Study.find(params[:id])
    if url_for() != url_for(:id => @study)
      return redirect_to :id => @study, status: :moved_permanently
    end

    @region_results = @study.region_results.to_a
    sortable_column_order do |column, direction|
      case column
      when 'name', 'percent_favored', 'chosen', 'rejected', 'locations', 'total'
        if direction.to_s == 'asc'
          @region_results.sort! {|a,b| a[column] <=> b[column]}
        else
          @region_results.sort! {|a,b| b[column] <=> a[column]}
        end
      else
          @region_results.sort! {|a,b| b['locations'] <=> a['locations']}
      end
    end

    page = params[:page].nil? ? 1 : params[:page]
    per_page = 10

    @page_results = @region_results.paginate(:page => page, :per_page => per_page)

    respond_to do |format|
      format.html # region_results.html.erb
    end
  end

  # GET /studies/1/heatmap
  def heatmap
    @study = Study.find(params[:id])
    if url_for() != url_for(:id => @study)
      return redirect_to :id => @study, status: :moved_permanently
    end

    respond_to do |format|
      format.html # heatmap.html.erb
    end
  end

  # GET /studies/1/download
  def download
    @study = Study.find(params[:id])
    if url_for() != url_for(:id => @study)
      return redirect_to :id => @study, status: :moved_permanently
    end

    respond_to do |format|
      format.html # download.html.erb
    end
  end

  # GET /studies/1/vote
  def vote
    @study = Study.find(params[:id])
    if url_for() != url_for(:id => @study)
      return redirect_to :id => @study, status: :moved_permanently
    end

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
    if url_for() != url_for(:id => @study)
      return redirect_to url_for(:action => :curate, :id => @study) + "?region_id=" + params[:region_id], :status => :moved_permanently
    end

    @region = Region.find(params[:region_id])
    @locations = @region.locations.paginate(:page => params[:page], :per_page => 25)

    respond_to do |format|
      format.html # curate.html.erb
    end
  end

  # GET /studies/new
  # GET /studies/new.json
  def new
    @study = Study.new
    @study.question = 'Which place looks '
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @study }
    end
  end

  # GET /studies/1/edit
  def edit
    @study = Study.find(params[:id])
    if url_for() != url_for(:id => @study)
      return redirect_to :id => @study, status: :moved_permanently
    end
  end

  # POST /studies
  # POST /studies.json
  def create
    @study = Study.new(params[:study])
    @study.user_id = current_user.id

    # create and save the region set
    @region_set = RegionSet.new()
    if @study
      # name the imageset after the study if possible
      @region_set.name = @study.name + ' Image Set'
      @region_set.description = 'This is image set was created specifically for the study "' + @study.name + '"'
    end
    @region_set.user_id = current_user.id
    @region_set.save()

    @study.region_set_id = @region_set.id

    respond_to do |format|
      if @study.save

        format.html { redirect_to url_for(:controller => "regions", :action => "new") + '?study_id=' + @study.id.to_s() + '&region_set_id=' + @region_set.id.to_s(), notice: 'Study was successfully created.' }
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
        format.html { render action: "edit", notice: 'Study was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @study.errors, status: :unprocessable_entity }
      end
    end
  end

  def promote
    if current_user.admin
      @study = Study.find(params[:id])
      @study.promoted = true
      if @study.save
        respond_to do |format|
          format.html { redirect_to @study, notice: 'Study was successfully promoted to home page.' }
          format.json { head :no_content }
        end
      end
    end
  end

  def demote
    if current_user.admin
      @study = Study.find(params[:id])
      @study.promoted = false
      if @study.save
        respond_to do |format|
          format.html { redirect_to @study, notice: 'Study was successfully demoted from home page.' }
          format.json { head :no_content }
        end
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

    if !@study.region_set.nil?
      @study.region_set.destroy
    end

    @study.destroy

    respond_to do |format|
      format.html { redirect_to studies_url }
      format.json { head :no_content }
    end
  end

  # DELETE /studies/1
  # DELETE /studies/1.json
  def destroybadvotes
    @study = Study.find(params[:id])
    @study.comparisons_before_fix.each do |comparison|
      comparison.destroy
    end

    respond_to do |format|
      format.html { redirect_to studies_url }
      format.json { head :no_content }
    end
  end

  # Users can view results if
  # - they are an admin
  # - they own the study
  # - or it has been launched (!active.nil?) and it is public
  def can_view_results?
    @study = Study.find(params[:id])
    can_edit? ||  (!@study.active.nil? && @study.public)
  end

  def can_edit?
    @study = Study.find(params[:id])
    !current_user.nil? && (current_user.admin || (@study.user == current_user))
  end

  private

  #authorization
  def require_can_edit
    if !can_edit?
      trigger_403('You do not have permission to modify this resourse')
    end
  end

  def require_can_view_results
    if !can_view_results?
      trigger_403('You are trying to access a study that has not yet been launched and you are not the owner.')
    end
  end

  # Sorting behavior for studies
  def order
    order = sortable_column_order do |column, direction|
      case column
      when "name"
        "LOWER(studies.name) #{direction}"
      when "active", "public", "promoted"
        "studies.#{column} #{direction}"
      else
        'LOWER(studies.name) ASC'
      end
    end
  end

end
