class RegionSetMembershipsController < ApplicationController
  # GET /region_set_memberships
  # GET /region_set_memberships.json
  def index
    @region_set_memberships = RegionSetMembership.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @region_set_memberships }
    end
  end

  # GET /region_set_memberships/1
  # GET /region_set_memberships/1.json
  def show
    @region_set_membership = RegionSetMembership.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @region_set_membership }
    end
  end

  # GET /region_set_memberships/new
  # GET /region_set_memberships/new.json
  def new
    @region_set_membership = RegionSetMembership.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @region_set_membership }
    end
  end

  # GET /region_set_memberships/1/edit
  def edit
    @region_set_membership = RegionSetMembership.find(params[:id])
  end

  # POST /region_set_memberships
  # POST /region_set_memberships.json
  def create
    @region_set_membership = RegionSetMembership.new(params[:region_set_membership])

    respond_to do |format|
      if @region_set_membership.save
        format.html { redirect_to @region_set_membership, notice: 'Region set membership was successfully created.' }
        format.json { render json: @region_set_membership, status: :created, location: @region_set_membership }
      else
        format.html { render action: "new" }
        format.json { render json: @region_set_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /region_set_memberships/1
  # PUT /region_set_memberships/1.json
  def update
    @region_set_membership = RegionSetMembership.find(params[:id])

    respond_to do |format|
      if @region_set_membership.update_attributes(params[:region_set_membership])
        format.html { redirect_to @region_set_membership, notice: 'Region set membership was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @region_set_membership.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /region_set_memberships/1
  # DELETE /region_set_memberships/1.json
  def destroy
    @region_set_membership = RegionSetMembership.find(params[:id])
    @region_set_membership.destroy

    respond_to do |format|
      format.html { redirect_to region_set_memberships_url }
      format.json { head :no_content }
    end
  end
end
