require 'spec_helper'

describe "region_set_memberships/edit" do
  before(:each) do
    @region_set_membership = assign(:region_set_membership, stub_model(RegionSetMembership,
      :region_set_id => 1,
      :region_id => 1
    ))
  end

  it "renders the edit region_set_membership form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", region_set_membership_path(@region_set_membership), "post" do
      assert_select "input#region_set_membership_region_set_id[name=?]", "region_set_membership[region_set_id]"
      assert_select "input#region_set_membership_region_id[name=?]", "region_set_membership[region_id]"
    end
  end
end
