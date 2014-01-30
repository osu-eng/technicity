require 'spec_helper'

describe 'Session' do

  # Make sure I'm signed in before we start
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit '/users/sign_in'
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password
    click_button 'Sign in'
  end

  it 'should reset if adding a survey when previously unlimited' do
    # create study with unlimited voting
    @study = FactoryGirl.create(:study, user_id: @user.id, has_survey: false, limit_votes: false)

    # this will start the session
    visit "/studies/#{@study.id}/vote"

    # change this to have a survey
    visit "/studies/#{@study.id}/edit"
    choose 'study_has_survey_true'
    fill_in 'Total number of votes', with: '13'
    click_button 'Save'

    # expect everything to work
    visit "/studies/#{@study.id}/vote"
    expect(page).to have_content(@study.name)

  end
end
