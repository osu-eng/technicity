class SurveysController < ApplicationController

  before_filter :authenticate_user!, only: [ :new, :update, :create]
  before_filter :require_can_edit, only: [ :create, :update ]

  # GET /surveys/1
  # GET /surveys/1.json
  def show
    @survey = Survey.find(params[:id])
    @study = Study.where(survey_id: @survey.id).first
    @surveyForm = SurveyTakerForm.new(@survey, @study.id)

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
    @initial_setup = params[:is].present? ? {is: 1} : {}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @survey }
    end
  end

  # GET /surveys/1/edit
  def edit
    @survey = Survey.find(params[:id])
    #assumes one survey per study
    @study = Study.where(survey_id: params[:id]).first
  end

  # POST /surveys
  # POST /surveys.json
  def create
    @study_id = params[:survey][:study_id]
    @surveyForm = SurveyCreationForm.new(params[:survey])

    respond_to do |format|
      if @surveyForm.save
        path_params = params[:is].present? ? {is: 1} : {}
        format.html { redirect_to survey_questions_path(@surveyForm.survey, path_params), notice: 'Survey was successfully created.' }
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
        format.html { redirect_to edit_survey_path, notice: 'Survey was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        #format.json { render json: @survey.errors, status: :unprocessable_entity }
      end
    end
  end

  def can_edit?
    begin
      if params[:survey] && params[:survey][:study_id]
        @study = Study.find(params[:survey][:study_id])
      else
        @study = Study.where(survey_id: params[:id]).first
      end
    rescue
      return false
    end

    !current_user.nil? && (current_user.admin || (@study.user == current_user))
  end

  def can_view_results?
    @study = Study.where(survey_id: params[:id]).first
    can_edit? ||  (!@study.active.nil? && @study.public)
  end

  private

  #authorization
  def require_can_edit
    unless can_edit?
      trigger_403('You do not have permission to modify this resource.')
    end
  end

end
