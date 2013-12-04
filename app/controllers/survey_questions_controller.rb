class SurveyQuestionsController < ApplicationController

  before_filter :authenticate_user!, only: [ :new, :update, :destroy, :create]
  before_filter :require_can_edit, only: [ :update, :destroy, :create ]

  # GET /survey_questions
  # GET /survey_questions.json
  def index
    @survey_id = params[:survey_id]
    @survey_questions = SurveyQuestion.where(survey_id: @survey_id)
    @study = Study.where(survey_id: params[:survey_id]).first
    @initial_setup = params[:is].present? ? {is: 1} : {}

    respond_to do |format|
      format.html # index.html.erb
      #format.json { render json: @survey_questions }
    end
  end

  # GET /survey_questions/1
  # GET /survey_questions/1.json
  def show
    @survey_question = SurveyQuestion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      #format.json { render json: @survey_question }
    end
  end

  # GET /survey_questions/new
  # GET /survey_questions/new.json
  def new
    @survey_question = SurveyQuestion.new
    2.times { @survey_question.survey_options.build }
    @initial_setup = params[:is].present? ? {is: 1} : {}

    respond_to do |format|
      format.html # new.html.erb
      #format.json { render json: @survey_question }
    end
  end

  # GET /survey_questions/1/edit
  def edit
    @survey_question = SurveyQuestion.find(params[:id])

    # just in case someone saved a question without any answers
    if @survey_question.survey_options.blank?
      2.times { @survey_question.survey_options.build }
    end
  end

  # POST /survey_questions
  # POST /survey_questions.json
  def create
    #if this is during initial set up pass the state var 'is' and set to one
    path_params = params[:survey_question].extract!(:is)[:is].present? ? {is: 1} : {}

    params[:survey_question][:survey_id] = params[:survey_id]
    @survey_question = SurveyQuestion.new(params[:survey_question])

    respond_to do |format|
      if @survey_question.save

        format.html { redirect_to survey_questions_path(path_params), notice: 'Survey question was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /survey_questions/1
  # PUT /survey_questions/1.json
  def update
    @survey_question = SurveyQuestion.find(params[:id])

    respond_to do |format|
      if @survey_question.update_attributes(params[:survey_question])
        format.html { redirect_to @survey_question, notice: 'Survey question was successfully updated.' }
        #format.json { head :no_content }
      else
        format.html { render action: "edit" }
        #format.json { render json: @survey_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /survey_questions/1
  # DELETE /survey_questions/1.json
  def destroy
    @survey_question = SurveyQuestion.find(params[:id])
    @survey_question.destroy
    @initial_setup = params[:is].present? ? {is: 1} : {}

    respond_to do |format|
      format.html { redirect_to survey_questions_url(@initial_setup) }
     # format.json { head :no_content }
    end
  end

  def can_edit?
    begin
      @study = Study.where(survey_id: params[:survey_id]).first
    rescue
      return false
    end

    !current_user.nil? && (current_user.admin || (@study.user == current_user))
  end

  def can_view_results?
    @study = Study.where(survey_id: params[:survey_id]).first
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
