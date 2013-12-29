class StaticPagesController < ApplicationController
  def home
    session[:homepage_study].present? ? process_survey_sessions : init_survey_sessions
  end

  def help
  end

  def about
  end

  def denied
  end

  private

  def init_survey_sessions
    session[:completed_studies] = [] if session[:completed_studies].blank?
    @study = Study.random(session[:completed_studies])
    if @study.present?
      study_key = @study.slug.to_sym
      session[:homepage_study] = @study.id
      session[study_key] = {}
      session[study_key][:study_id] = @study.id
      session[study_key][:total_steps] = @study.limit_votes.present? ? @study.survey_required_votes : 10
      session[study_key][:current_step] = 1
    end
  end

  def process_survey_sessions
    @study = Study.find_by_id(session[:homepage_study])
    if @study.nil? || session[@study.slug.to_sym].nil?
      # If these error conditions come up, a study may have been deleted
      # Bail out and reinit sessions
      init_survey_sessions
    else 
      study_key = @study.slug.to_sym
      if session[study_key][:current_step] > session[study_key][:total_steps]
        if @study.has_survey
          redirect_to survey_path(@study.survey_id)
        else
          session.delete(:homepage_study)
          session.delete(study_key)
          session[:completed_studies] << @study.id
          redirect_to home_path
        end
      end
    end
  end


end
