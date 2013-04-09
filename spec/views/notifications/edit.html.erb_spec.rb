require 'spec_helper'

describe "notifications/edit" do
  before(:each) do
    @notification = assign(:notification, stub_model(Notification,
      :name => "MyString",
      :email => "MyString"
    ))
  end

  it "renders the edit notification form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do
      assert_select "input#notification_name[name=?]", "notification[name]"
      assert_select "input#notification_email[name=?]", "notification[email]"
    end
  end
end
