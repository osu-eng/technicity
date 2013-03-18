class RegionSetsController < ApplicationController
  # GET /region_sets
  # GET /region_sets.json
  def index
    @region_sets = RegionSet.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @region_sets }
    end
  end

  # GET /region_sets/1
  # GET /region_sets/1.json
  def show
    @region_set = RegionSet.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @region_set }
    end
  end

  # GET /region_sets/new
  # GET /region_sets/new.json
  def new
    @region_set = RegionSet.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @region_set }
    end
  end

  # GET /region_sets/1/edit
  def edit
    @region_set = RegionSet.find(params[:id])
  end

  # POST /region_sets
  # POST /region_sets.json
  def create
    @region_set = RegionSet.new(params[:region_set])

    respond_to do |format|
      if @region_set.save
        format.html { redirect_to @region_set, notice: 'Region set was successfully created.' }
        format.json { render json: @region_set, status: :created, location: @region_set }
      else
        format.html { render action: "new" }
        format.json { render json: @region_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /region_sets/1
  # PUT /region_sets/1.json
  def update
    @region_set = RegionSet.find(params[:id])

    respond_to do |format|
      if @region_set.update_attributes(params[:region_set])
        format.html { redirect_to @region_set, notice: 'Region set was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @region_set.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /region_sets/1
  # DELETE /region_sets/1.json
  def destroy
    @region_set = RegionSet.find(params[:id])
    @region_set.destroy

    respond_to do |format|
      format.html { redirect_to region_sets_url }
      format.json { head :no_content }
    end
  end
end
