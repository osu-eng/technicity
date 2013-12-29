require 'spec_helper'

describe 'Survey' do

  describe 'creation' do
    # Make sure I'm signed in before we start
    before(:each) do
      @user = FactoryGirl.create(:user)
      visit '/users/sign_in'
      fill_in 'Username', with: @user.username
      fill_in 'Password', with: @user.password
      click_button 'Sign in'
    end

    it 'should not let me create a survey against a study I do not own' do
      bad_user_id = @user.id + 1
      @study = FactoryGirl.create(:study, user_id: bad_user_id)

      visit 'surveys/new?study_id=' + @study.id.to_s
      fill_in 'Title', with: 'test name'
      fill_in 'Instructions / Description', with: 'test description'
      click_button 'Create Survey'
      expect(page).to have_content('You do not have permission to access this resource at this time')
    end

    it 'should let me create a survey against a study I do own' do
      @study = FactoryGirl.create(:study, user_id: @user.id)

      visit 'surveys/new?study_id=' + @study.id.to_s
      fill_in 'Title', with: 'test name'
      fill_in 'Instructions / Description', with: 'test description'
      click_button 'Create Survey'
      expect(page).to have_content('Survey was successfully created.')
    end

    it 'should save survey_id in associated study' do
      @study = FactoryGirl.create(:study, user_id: @user.id)

      visit 'surveys/new?study_id=' + @study.id.to_s
      fill_in 'Title', with: 'test name'
      fill_in 'Instructions / Description', with: 'test description'
      click_button 'Create Survey'

      expect(Study.last.survey_id).to eq(Survey.last.id)
    end

    it 'should warn for respondent privacy on survey creation in private studies' do
      @study = FactoryGirl.create(:study, public: false, user_id: @user.id)

      visit 'surveys/new?study_id=' + @study.id.to_s
      
      expect(page).to have_content('PRIVATE')
    end

  end

end
