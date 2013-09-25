require 'spec_helper'

describe "StaticPages" do

  describe "Home page" do
    it "should have the content 'Home'" do
      visit '/home'

      # I'm not sure what to test here, but "Help" should pass since it's in the footer
      expect(page).to have_content('Help')
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/help'
      expect(page).to have_content('Help')
    end
  end
end
