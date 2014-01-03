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

    # add geocoder lat and long
    @comparison.voter_latitude = request.location.present? ? request.location.latitude : 0
    @comparison.voter_longitude = request.location.present? ? request.location.longitude : 0

    @comparison.voter_remote_ip = request.remote_ip
    @comparison.voter_session_id = request.session_options[:id]

    respond_to do |format|
      if @comparison.save
        increment_counter
        format.html { redirect_to :back, notice: 'Thanks for your vote!' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { redirect_to :back, notice: 'There was an error and your vote was not saved. Please try again.' }
        format.json { render json: @comparison.errors, status: :unprocessable_entity }
      end
    end
  end

  def increment_counter
    @study = Study.find(params[:comparison][:study_id])
    study_key = @study.slug.to_sym
    if session[study_key].present? && session[study_key][:current_step].present?
      session[study_key][:current_step] += 1
    end
  end

end
