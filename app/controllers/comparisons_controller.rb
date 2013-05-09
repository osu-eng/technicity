class ComparisonsController < ApplicationController

  # GET /comparisons
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # POST /comparisons
  # POST /comparisons.json
  def create
    @comparison = Comparison.new(params[:comparison])

    # Set info for the voter to allow interesting analysis / functionality
    @comparison.voter_latitude = request.location.latitude
    @comparison.voter_longitude = request.location.longitude
    @comparison.voter_remote_ip = request.remote_ip
    @comparison.voter_session_id = request.session_options[:id]

    respond_to do |format|
      if @comparison.save
        format.html { redirect_to :back, notice: 'Thanks for your vote!' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @comparison.errors, status: :unprocessable_entity }
      end
    end
  end


end
