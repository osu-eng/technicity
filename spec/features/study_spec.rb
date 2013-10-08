require 'spec_helper'

describe 'Study' do


  # Make sure I'm signed in before we start
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit '/users/sign_in'
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

  end
  
  describe 'creation process' do

    it 'should let me create a new study with a survey and limited votes' do
      visit '/studies/new'
      fill_in 'Question for Voter', with: 'Which place looks friendlier?'
      fill_in 'Name', with: 'My friendly study.'
      fill_in 'Description', with: 'Example description'
      choose 'study_has_survey_true'
      fill_in 'Total number of votes', with: '13'
      choose 'study_public_true'
      click_button 'Create Study'

      expect(page).to have_content('Study was successfully created')
    end

    it 'should let me create a new study with no survey and unlimited votes' do
      visit '/studies/new'
      fill_in 'Question for Voter', with: 'Which place looks friendlier?'
      fill_in 'Name', with: 'My friendly study.'
      fill_in 'Description', with: 'Example description'
      choose 'study_has_survey_false'
      choose 'study_limit_votes_false'
      choose 'study_public_true'
      click_button 'Create Study'

      expect(page).to have_content('Study was successfully created')
    end

  end
end