require 'spec_helper'

describe 'edit user account info' do

  # Make sure I'm signed in before we start
  before(:all) do
    @user = FactoryGirl.create(:user)
    visit '/users/sign_in'
    fill_in 'Username', with: @user.username
    fill_in 'Password', with: @user.password
    click_button 'Sign in'

  end

  after(:all) do
    @user.destroy
  end

  it 'should let me change my password' do
    new_pass = 'mynewpassword'

    visit '/users/edit'
    fill_in 'New Password', with: new_pass
    fill_in 'Confirm New Password', with: new_pass
    click_button 'Update'

    expect(current_path).to eq(edit_user_registration_path)
    expect(page).to have_content('You updated your account successfully.')
  end
end
