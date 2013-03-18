require 'spec_helper'

describe "region_sets/index" do
  before(:each) do
    assign(:region_sets, [
      stub_model(RegionSet,
        :user_id => 1,
        :slug => "Slug",
        :name => "Name",
        :public => false
      ),
      stub_model(RegionSet,
        :user_id => 1,
        :slug => "Slug",
        :name => "Name",
        :public => false
      )
    ])
  end

  it "renders a list of region_sets" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Slug".to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
