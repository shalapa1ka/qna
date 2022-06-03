# frozen_string_literal: true

require 'rails_helper'

feature 'Sign in \ Sing out' do
  given(:user) { create :user }

  scenario 'Signing in with correct credentials' do
    sing_in_user user
    expect(page).to have_content 'Signed in successfully.'
  end

  given(:other_user) { create :user }

  scenario 'Signing in as another user' do
    visit new_user_session_path
    within('.new_user') do
      fill_in 'Email', with: 'wrong@email.com'
      fill_in 'Password', with: other_user.password
    end
    click_button 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
    expect(current_path).to eq '/users/sign_in'
  end

  scenario 'Signing out' do
    sing_in_user user
    expect(page).to have_content 'Signed in successfully.'
    click_button 'Sign out'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end
