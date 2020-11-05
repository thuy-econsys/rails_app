require 'rails_helper'

feature 'Sign up' do
  let(:test_user) { attributes_for(:user) }

  context 'when sign up is successful' do
    scenario 'redirects to home' do
      sign_up(test_user)
      expect(current_path).to eq('/')
    end
    scenario 'has successful sign-up notice' do
      sign_up(test_user)
      expect(page).to have_css('p.notice', :text => 'Welcome! You have signed up successfully.')
    end
    scenario "has correct content" do
      sign_up(test_user)
      expect(page).to have_css('h1', :text => 'Home Page' )
    end
  end

  context 'when email is blank' do
    scenario 'redirects to users path sign up page' do
      test_user[:email] =""
      sign_up(test_user)
      expect(current_path).to eq('/users')
      expect(page).to have_css('h1', :text => 'Sign up')
    end
    scenario 'returns error alert' do
      test_user[:email] =""
      sign_up(test_user)
      expect(page).to have_css('div.alert li', :text => 'Email can\'t be blank')
    end
  end

  context 'when password confirmation doesn\'t match password' do
    scenario 'redirects to users path sign up page' do
      test_user[:password_confirmation] = "wrong-password"
      sign_up(test_user)
      expect(current_path).to eq('/users')
      expect(page).to have_css('h1', :text => 'Sign up')
    end
    scenario 'returns error alert' do
      test_user[:password_confirmation] = "wrong-password"
      sign_up(test_user)
      expect(page).to have_css('div.alert li', :text => 'Password confirmation doesn\'t match Password')
    end
  end
end