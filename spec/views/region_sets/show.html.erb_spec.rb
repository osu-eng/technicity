require 'spec_helper'

describe "region_sets/show" do
  before(:each) do
    @region_set = assign(:region_set, stub_model(RegionSet,
      :user_id => 1,
      :slug => "Slug",
      :name => "Name",
      :public => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    rendered.should match(/Slug/)
    rendered.should match(/Name/)
    rendered.should match(/false/)
  end
end
