require 'spec_helper'

describe Survey do

  before(:each) do
    @survey = FactoryGirl.create(:survey_with_questions, question_count: 2)
  end

  it 'relates to survey_questions' do
    expect(@survey.survey_questions.count).to eq(2)
  end

end
