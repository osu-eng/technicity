require 'spec_helper'

describe SurveyOption do

  before(:each) do
    @survey_option = FactoryGirl.create(:survey_option, option: 'green')
  end

  it 'fetches from the database correctly' do
    expect(@survey_option.option).to eq('green')
  end

end
