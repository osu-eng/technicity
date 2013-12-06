class StaticPagesController < ApplicationController
  def home
    if session[:homepage_study].present?
      @study = Study.find(session[:homepage_study])
      study_key = @study.slug.to_sym
      session[study_key][:current_step] += 1
      if session[study_key][:current_step] > session[study_key][:current_step]
        redirect_to show_survey_path(@study)
      end
    else
      @study = Study.random
      study_key = @study.slug.to_sym
      session[:homepage_study] = @study.id
      session[study_key] = {}
      session[study_key][:study_id] = @study.id
      session[study_key][:total_steps] = @study.limit_votes.present? ? @study.survey_required_votes : 10
      session[study_key][:current_step] = 1
    end
  end

  def help
  end

  def about
  end

  def denied
  end
end
