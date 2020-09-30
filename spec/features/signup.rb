require 'rails_helper'
  # TODO troubleshoot invalid form inputs as user param outputs let symbols? 

feature 'Sign up' do
  let(:test_user) { attributes_for(:user) }
  let(:no_email) { attributes_for(:user, email: "")}
  let(:password_not_a_match) { attributes_for(:user, password_confirmation: "wrongpassword") }

  context 'when sign up is successful' do
    scenario 'redirects to home' do
      sign_up(:test_user)
      expect(current_path).to eq('/')
    end
    scenario 'has correct content' do
      sign_up(:test_user)
      expect(page).to have_content('Welcome! You have signed up successfully.')
    end
  end

  context 'when email is blank' do
    xscenario 'redirects to users path' do
      # byebug
      sign_up(:no_email)
      expect(current_path).to eq('/users')
    end
    xscenario 'returns error message' do
      sign_up(:no_email)
      expect(page).to have_content('Email can\'t be blank')
    end
  end

  context 'when password confirmation doesn\'t match password' do
    xscenario 'redirects to users path' do
      # byebug
      sign_up(:password_not_a_match)
      expect(current_path).to eq('/users')
    end
    xscenario 'returns error message' do
      sign_up(:password_not_a_match)
      expect(page).to have_content('Password confirmation doesn\'t match Password')
    end
  end
end