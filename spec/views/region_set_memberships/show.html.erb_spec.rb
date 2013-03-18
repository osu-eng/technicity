require 'spec_helper'

describe "region_set_memberships/show" do
  before(:each) do
    @region_set_membership = assign(:region_set_membership, stub_model(RegionSetMembership,
      :region_set_id => 1,
      :region_id => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/2/)
  end
end
