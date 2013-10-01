require 'spec_helper'

describe SurveyResponse do
  before(:each) do
    @survey_response = FactoryGirl.create(:survey_response, voter_session: '1234')
  end

  it 'fetches from the database correctly' do
    expect(@survey_response.voter_session).to eq('1234')
  end
end
