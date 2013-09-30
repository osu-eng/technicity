require 'spec_helper'

describe 'allow a user to log in' do

  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'should log me in normally' do
    visit '/users/sign_in'
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

    expect(page).to have_content('Signed in successfully.')
  end
end