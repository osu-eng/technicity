require 'spec_helper'

describe 'User sign up process' do

  it 'signs me up normally' do
    visit '/users/sign_up'
    fill_in 'Name', :with => 'Brutus Buckeye'
    fill_in 'Username', :with => 'bbuckeye'
    fill_in 'Email', :with => 'buckeye.1@testing.com'
    fill_in 'user_password', :with => 'wearenuts'
    fill_in 'user_password_confirmation', :with => 'wearenuts'
    click_button 'Sign up'

    expect(page).to have_content('You have signed up successfully')
  end

end