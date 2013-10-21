require 'spec_helper'

describe 'survey question' do

  # Make sure I'm signed in before we start
  before(:each) do
    @user = FactoryGirl.create(:user)
    visit '/users/sign_in'
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

  end

  describe 'creation process' do
    it 'should create a question with answers' do
      @survey = FactoryGirl.build_stubbed(:survey)

      # we need an existing study that is associated with us to pass authorization
      @study = FactoryGirl.create(:study, user_id: @user.id, survey_id: @survey.id)

      visit "/surveys/#{@survey.id}/questions/new"
      fill_in 'Survey Question', with: 'Does this pass the test?'
      fill_in 'survey_question_survey_options_attributes_0_option', with: 'Yes'
      fill_in 'survey_question_survey_options_attributes_1_option', with: 'No'
      # I don't think the follow works without a javascript driver
      #click_link 'Add an answer'
      #fill_in 'survey_question_survey_options_attributes_2_option', with: 'Maybe'
      choose 'survey_question_multiple_choice_true'
      click_button 'Create Question'
      expect(page).to have_content('Survey question was successfully created.')
    end
  end
end
