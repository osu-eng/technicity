require 'spec_helper'

describe SurveyResponse do

  let(:survey_response) { FactoryGirl.create(:survey_response, voter_session_id: '1234') }

  it 'fetches from the database correctly' do
    expect(survey_response.voter_session_id).to eq('1234')
  end

  it 'should list of question and answers by study' do
    @survey = FactoryGirl.create(:survey_with_questions_and_options_and_responses)
    @study = FactoryGirl.create(:study, survey_id: @survey.id)

    qa = @study.survey_responses.questions_and_answers('1234').first

    expect(qa.question).to eq('What color are your eyes?')
    expect(qa.answer).to eq('Blue,Blue')
  end

end
