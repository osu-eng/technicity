require 'spec_helper'

describe 'Homepage Voting' do

  it 'should increment counter when voting' do

    @survey = FactoryGirl.create(:survey)
    @study = FactoryGirl.create(:study_with_region_set, survey_id: @survey.id, active: true)

    #visit the homepage
    visit '/'

    # vote on the first image
    click_link '1'

    #pager should have incremented
    expect(page).to have_content('2 / 10')

  end

end
