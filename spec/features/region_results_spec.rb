require 'spec_helper'

describe 'Region Results' do

  before(:each) do
    @study = FactoryGirl.create(:study_with_region_set, has_survey: false)
    @region = FactoryGirl.create(:region, name: 'Columbus')
    @region_set_membership = FactoryGirl.create(:region_set_membership, region_set: @study.region_set, region: @region)
  end

  it 'should correctly sort' do
    #record a comparison
    visit "/studies/#{@study.id}/vote"
    click_link '1'
    expect(page).to have_content('Thanks for your vote!')

    #visit analyze and see if sorting works
    visit "/studies/#{@study.id}/region_results?page=1&sort=chosen"

    # make sure we are still stuff on the page
    expect(page).to have_content('Columbus')
    expect(page).to have_content('Cincinnati')

  end
end
