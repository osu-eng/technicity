require 'spec_helper'

describe SurveyQuestionsController do

  describe 'routing' do

    it 'routes to #index' do
      get('/surveys/1/questions').should route_to('survey_questions#index', survey_id: '1')
    end

    it 'routes to #new' do
      get('/surveys/1/questions/new').should route_to('survey_questions#new', survey_id: '1')
    end

    it 'routes to #show' do
      get('/surveys/1/questions/2').should route_to('survey_questions#show', survey_id: '1', :id => '2')
    end

    it 'routes to #edit' do
      get('/surveys/1/questions/2/edit').should route_to('survey_questions#edit', survey_id: '1', :id => '2')
    end

    it 'routes to #create' do
      post('/surveys/1/questions').should route_to('survey_questions#create', survey_id: '1')
    end

    it 'routes to #update' do
      put('/surveys/1/questions/2').should route_to('survey_questions#update', survey_id: '1', :id => '2')
    end

    it 'routes to #destroy' do
      delete('/surveys/1/questions/2').should route_to('survey_questions#destroy', survey_id: '1', :id => '2')
    end

  end
end
