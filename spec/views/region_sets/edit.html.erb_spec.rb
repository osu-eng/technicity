require 'spec_helper'

describe "region_sets/edit" do
  before(:each) do
    @region_set = assign(:region_set, stub_model(RegionSet,
      :user_id => 1,
      :slug => "MyString",
      :name => "MyString",
      :public => false
    ))
  end

  it "renders the edit region_set form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", region_set_path(@region_set), "post" do
      assert_select "input#region_set_user_id[name=?]", "region_set[user_id]"
      assert_select "input#region_set_slug[name=?]", "region_set[slug]"
      assert_select "input#region_set_name[name=?]", "region_set[name]"
      assert_select "input#region_set_public[name=?]", "region_set[public]"
    end
  end
end
