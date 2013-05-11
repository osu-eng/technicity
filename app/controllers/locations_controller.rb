class LocationsController < ApplicationController

  before_filter :authenticate_user!, only: [ :create, :update, :destroy]
  before_filter :require_can_edit, only: [ :update, :destroy]

  # GET /locations
  # GET /locations.json
  # def index
  #  @locations = Location.all

  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @locations }
  #  end
  #end

  # GET /locations/1
  # GET /locations/1.json
  def show
    @location = Location.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @location }
    end
  end

  # GET /locations/new
  # GET /locations/new.json
  #def new
  #  @location = Location.new
  #
  #  respond_to do |format|
  #    format.html # new.html.erb
  #    format.json { render json: @location }
  #  end
  #end

  # GET /locations/1/edit
  # def edit
  #  @location = Location.find(params[:id])
  #end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(params[:location])
    unless current_user.admin || (@location.region.user == current_user)
      return trigger_403('You can not add a location to this region')
    end

    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: "new" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /locations/1
  # PUT /locations/1.json
  def update
    @location = Location.find(params[:id])

    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render json: @location}
      else
        format.html { render action: "edit" }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    flash[:notice] = "Successfully deleted image."
    respond_to do |format|
      format.html { redirect_to locations_url }
      format.json { render json: @location}
    end
  end

  def can_edit?
    @location = Location.find(params[:id])
    !current_user.nil? && (current_user.admin || (@location.region.user == current_user))
  end

  private

  #authorization
  def require_can_edit
    if !can_edit?
      trigger_403('You do not have permission to modify this resourse')
    end
  end

end
