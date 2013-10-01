require 'spec_helper'

describe SurveyQuestion do

  before(:each) do
    @survey_question = FactoryGirl.create(:survey_question_with_options, option_count: 2)
  end

  it 'relates to survey_options' do
    expect(@survey_question.survey_options.count).to eq(2)
  end
end
