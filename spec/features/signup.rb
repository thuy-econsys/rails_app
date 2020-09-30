require 'rails_helper'

feature 'Sign up' do
  let(:test_user) { attributes_for(:user) }

  context 'when sign up is successful' do
    scenario 'redirects to home' do
      sign_up(test_user)
      expect(current_path).to eq('/')
    end
    scenario 'has correct content' do
      sign_up(test_user)
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  context 'when email is blank' do
    scenario 'redirects to users path sign up page' do
      # byebug
      test_user[:email] =""
      sign_up(test_user)
      expect(current_path).to eq('/users')
      expect(page).to have_content('Sign up')
    end
    scenario 'returns error message' do
      test_user[:email] =""
      sign_up(test_user)
      expect(page).to have_content('Email can\'t be blank')
    end
  end

  context 'when password confirmation doesn\'t match password' do
    scenario 'redirects to users path sign up page' do
      # byebug
      test_user[:password_confirmation] = "wrong-password"
      sign_up(test_user)
      expect(current_path).to eq('/users')
      expect(page).to have_content('Sign up')
    end
    scenario 'returns error message' do
      test_user[:password_confirmation] = "wrong-password"
      sign_up(test_user)
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end
  end
end