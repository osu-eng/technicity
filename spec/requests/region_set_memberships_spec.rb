require 'spec_helper'

describe "RegionSetMemberships" do
  describe "GET /region_set_memberships" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get region_set_memberships_path
      response.status.should be(200)
    end
  end
end
