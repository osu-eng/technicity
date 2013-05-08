class RegionsController < ApplicationController

  before_filter :authenticate_user!, only: [ :new, :update, :destroy, :create]
  before_filter :require_can_edit, only: [ :update, :destroy ]

  # GET /regions
  # GET /regions.json
  #def index
  #  @regions = Region.all
  #
  #  respond_to do |format|
  #    format.html # index.html.erb
  #    format.json { render json: @regions }
  #  end
  #end

  # GET /regions/new
  # GET /regions/new.json
  def new
    @region = Region.new

    # A study to redirect to afterwards
    if (!params[:study_id].nil?)
      @study = Study.find(params[:study_id])
    end
    if (!params[:region_set_id].nil?)
      @region_set = RegionSet.find(params[:region_set_id])
    end

    # Whether or not to automatically create a region_set containing this region
    @create_set = params[:create_set]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @region }
    end
  end

  # GET /regions/1/edit
  #def edit
  #  @region = Region.find(params[:id])
  #end

  # POST /regions
  # POST /regions.json
  def create
    @region = Region.new(params[:region])
    @region.user_id = current_user.id

    # security - load a study if one has been passed in
    if params[:study_id]
      @study = Study.find(params[:study_id])
      if @study.user != current_user
        trigger_403('You cannot add a region to this study')
      end
    end

    # security - load a region_set if one has been passed in
    if params[:region_set_id]
      @region_set = RegionSet.find(params[:region_set_id])
      if @region_set.user != current_user
        trigger_403('You cannot add a region to this region_set')
      end
    end

    # attempt to save the region
    if @region.save()

      # add locations to region
      if (!params[:points].empty?)
        points = params[:points].scan /([\d.-]+)[^\d.-]+([\d.-]+)/
        points.each do |point|
          l = Location.new()
          l.region_id = @region.id
          l.latitude = point[0].to_f
          l.longitude = point[1].to_f
          l.heading = rand(360)
          l.pitch = 0
          l.save()
        end
      end

      # If the create set flag is set, we need to create a region_set
      if params[:create_set]

        # create and save the region set
        @region_set = RegionSet.new()
        if @study
          # name the imageset after the study if possible
          @region_set.name = @study.name + ' Image Set'
          @region_set.description = 'This is image set was created specifically for the study "' + @study.name + '"'
        else
          # use region name as backup
          @region_set.name = @region.name + ' Image Set'
          @region_set.description = 'This is image set was created specifically for the region "' + @region.name + '"'
        end
        @region_set.user_id = current_user.id
        @region_set.save()

        # add the region set to the study
        if @study
          @study.region_set_id = @region_set.id
          @study.save()
        end
      end

      # if a region set exists, tie this new region to it
      if @region_set
        @rsm = RegionSetMembership.new()
        @rsm.region_set_id = @region_set.id
        @rsm.region_id = @region.id
        @rsm.save()
      end
    end


    respond_to do |format|
      if !@region.valid?

        # Whether or not to automatically create a region_set containing this region
        @create_set = params[:create_set]
        format.html { render action: "new" }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      else

        if @study
          if params[:add_another] == 'true'
            # should go back to this page without create_set flag
            format.html {
              redirect_to url_for(
                :controller => "regions",
                :action => "new",
                ) + '?study_id='+ @study.id.to_s() + '&region_set_id=' + @region_set.id.to_s(),
              notice: 'Area was successfully created.'
            }
          else
            # should go back to study curate page?
            format.html {
              redirect_to url_for(
                :controller => "studies",
                :action => "curate",
                :id => @study
                ) + '?region_id=' + @region.id.to_s(),
              notice: 'Area was successfully created.'
            }
          end
        elsif @rs
          # study logic duplicated here?
        else
          # Should go to local region curate?
          format.html { redirect_to @region, notice: 'Area was successfully created.' }
          format.json { render json: @region, status: :created, location: @region }
        end
      end
    end
  end

  # PUT /regions/1
  # PUT /regions/1.json
  def update
    @region = Region.find(params[:id])

    respond_to do |format|
      if @region.update_attributes(params[:region])
        format.html { redirect_to @region, notice: 'Area was successfully updated.' }
        format.json { render json: @region}
      else
        format.html { render action: "edit" }
        format.json { render json: @region.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regions/1
  # DELETE /regions/1.json
  def destroy
    @region = Region.find(params[:id])
    @region.destroy
    flash[:notice] = "Successfully deleted area."

    respond_to do |format|
      format.html { redirect_to regions_url }
      format.json { render json: @region}
    end
  end

  def can_edit?
    @region = Region.find(params[:id])
    !current_user.nil? && (current_user.admin || (@region.user == current_user))
  end

  private

  #authorization
  def require_can_edit
    if !can_edit?
      trigger_403('You do not have permission to modify this resourse')
    end
  end
end
