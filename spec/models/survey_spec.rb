require 'spec_helper'

describe Survey do

  before(:each) do
    @survey = FactoryGirl.create(:survey_with_questions, question_count: 2)
  end

  it 'relates to survey_questions' do
    expect(@survey.survey_questions.count).to eq(2)
  end

  it 'should return correct csv headers' do
    header = @survey.csv_header
    expect(header).to eq(['What color are your eyes?', 'What color are your eyes?'])
  end

  it 'should return correct csv rows' do

  end

end
