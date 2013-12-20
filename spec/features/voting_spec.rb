require 'spec_helper'

describe 'Voting' do

  before(:each) do
    @survey = FactoryGirl.create(:survey)
    @study = FactoryGirl.create(:study_with_region_set, survey_id: @survey.id, survey_required_votes: 3)
  end

  describe 'on the homepage' do

    it 'should increment counter when voting' do
      #visit the homepage
      visit '/'
      # vote on the first image
      click_link '1'
      #pager should have incremented
      expect(page).to have_content('2 / 3')
    end

    it 'should not increment counter when skipping image set' do
      visit '/'
      click_link "Can't decide, let's skip this one."
      expect(page).to have_content('1 / 3')
    end

    it 'should not redirect to a survey if survey was turned off' do

      @study.has_survey = false
      @study.save

      visit '/'
      3.times { click_link '1' }
      expect(current_path).to_not eq(survey_path(@survey))
    end

    it 'should redirect to a survey is study has one' do
      visit '/'
      3.times { click_link '1' }
      expect(current_path).to eq(survey_path(@survey))
    end

  end

  describe 'on the study voting page' do

    it 'should increment counter when voting' do
      visit vote_study_path(@study)
      click_link '1'
      expect(page).to have_content('2 / 3')
    end

    it 'should not increment counter when skipping image set' do
      visit vote_study_path(@study)
      click_link "Can't decide, let's skip this one."
      expect(page).to have_content('1 / 3')
    end

    it 'should not redirect to a survey if survey was turned off' do
      @study.has_survey = false
      @study.save

      visit vote_study_path(@study)
      3.times { click_link '1' }
      expect(current_path).to_not eq(survey_path(@survey))
    end

    it 'should redirect to a survey is study has one' do
      visit vote_study_path(@study)
      3.times { click_link '1' }
      expect(current_path).to eq(survey_path(@survey))
    end

    it 'should show an unlimited pager if votes are unlimited' do
      @study.has_survey = false
      @study.survey_required_votes = 0
      @study.limit_votes = false
      @study.save

      visit vote_study_path(@study)
      click_link '1'
      expect(page).to have_content('2 / Unlimited')
    end

  end

end
