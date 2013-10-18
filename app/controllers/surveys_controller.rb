class SurveysController < ApplicationController

  before_filter :authenticate_user!, only: [ :new, :update, :destroy, :create]
  before_filter :require_can_edit, only: [ :update, :destroy, :create ]


  # GET /surveys
  # GET /surveys.json
  def index
    @surveys = Survey.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @surveys }
    end
  end

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @survey = Survey.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @survey }
    end
  end

  # GET /surveys/new
  # GET /surveys/new.json
  def new
    @study_id = params[:study_id]
    @surveyForm = SurveyCreationForm.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey }
    end
  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find(params[:id])
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @study_id = params[:survey][:study_id]
    @surveyForm = SurveyCreationForm.new(params[:survey])

    respond_to do |format|
      if @surveyForm.save

        format.html { redirect_to @surveyForm.survey, notice: 'Survey was successfully created.' }
        #format.json { render json: @surveyForm.survey, status: :created, location: @survey }
      else
        format.html { render action: 'new' }
        #format.json { render json: @surveyForm.survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /surveys/1
  # PUT /surveys/1.json
  def update
    @survey = Survey.find(params[:id])

    respond_to do |format|
      if @survey.update_attributes(params[:survey])
        format.html { redirect_to @survey, notice: 'Survey was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /surveys/1
  # DELETE /surveys/1.json
  def destroy
    @survey = Survey.find(params[:id])
    @survey.destroy

    respond_to do |format|
      format.html { redirect_to surveys_url }
      format.json { head :no_content }
    end
  end

  def can_edit?
    begin
      @survey = Study.find(params[:survey][:study_id])
    rescue
      return false
    end

    !current_user.nil? && (current_user.admin || (@survey.user == current_user))
  end

  private

  #authorization
  def require_can_edit
    unless can_edit?
      trigger_403('You do not have permission to modify this resource.')
    end
  end

end
