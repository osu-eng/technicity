require 'spec_helper'

describe "region_set_memberships/index" do
  before(:each) do
    assign(:region_set_memberships, [
      stub_model(RegionSetMembership,
        :region_set_id => 1,
        :region_id => 2
      ),
      stub_model(RegionSetMembership,
        :region_set_id => 1,
        :region_id => 2
      )
    ])
  end

  it "renders a list of region_set_memberships" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
