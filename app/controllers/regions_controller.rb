class RegionsController < ApplicationController
  # GET /regions
  # GET /regions.json
  def index
    @regions = Region.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @regions }
    end
  end

  # GET /regions/1
  # GET /regions/1.json
  def show
    @region = Region.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @region }
    end
  end

  # GET /regions/new
  # GET /regions/new.json
  def new
    @region = Region.new

    # A study to redirect to afterwards
    if (!params[:study_id].nil?)
      @study = Study.find(params[:study_id])
    end

    # Whether or not to automatically create a region_set containing this region
    @create_set = params[:create_set]

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @region }
    end
  end

  # GET /regions/1/edit
  def edit
    @region = Region.find(params[:id])
  end

  # POST /regions
  # POST /regions.json
  def create
    @region = Region.new(params[:region])
    @region.user_id = current_user.id

    if params[:study_id]
      @study = Study.find(params[:study_id])
    end

    respond_to do |format|
      if @region.save()

        if params[:create_set]

          # create and save the region set
          @rs = RegionSet.new()
          @rs.name = @study.name + ' Image Set'
          @rs.user_id = current_user.id
          @rs.description = 'This is image set was created specifically for the study "' + @study.name + '"'
          @rs.save()

          # add an association between the new regionset and the region
          @rsm = RegionSetMembership.new()
          @rsm.region_set_id = @rs.id
          @rsm.region_id = @region.id
          @rsm.save()

          # add locations
          # return render :text => "The object is #{params[:points]}"
          if (!params[:points].empty?)
            points = params[:points].scan /([\d.-]+)[^\d.-]+([\d.-]+)/
            logger.debug "The object is #{points}"
            points.each do |point|
              l = Location.new()
              l.region_id = @region.id
              l.latitude = point[0].to_f
              l.longitude = point[1].to_f
              l.heading = 90
              l.pitch = 90
              l.save()
            end
          end

          # set the region set field of the study (security)
          if @study
            @study.region_set_id = @rs.id
            @study.save()
            format.html { redirect_to @study, notice: 'Area was successfully created.' }
          end
        end

        # show the region
        format.html { redirect_to @region, notice: 'Area was successfully created.' }
        format.json { render json: @region, status: :created, location: @region }
      else
        format.html { render action: "new" }
        format.json { render json: @region.errors, status: :unprocessable_entity }
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
        format.json { head :no_content }
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

    respond_to do |format|
      format.html { redirect_to regions_url }
      format.json { head :no_content }
    end
  end
end
