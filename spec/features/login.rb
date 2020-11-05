require 'rails_helper'

feature 'User login' do
  let!(:user_info) { create(:user) }

  context "when login is successful" do
    scenario "redirects to home page" do
      log_in(user_info)
      expect(current_path).to eq("/")
    end
    scenario "has successful sign-in notice" do
      log_in(user_info)
      expect(page).to have_css('p.notice', :text => 'Signed in successfully.')
    end
    scenario "has correct content" do
      log_in(user_info)
      expect(page).to have_css('h1', :text => 'Home Page' )
    end
  end

  context "when email is incorrect" do
    scenario "stays on sign-in page" do
      user_info.email = "wrong_email@gmail.com"
      log_in(user_info)
      expect(current_path).to eq("/users/sign_in")
      expect(page).to have_css('h1', :text => 'Log in')
    end
    scenario "returns error alert" do
      user_info.email = "wrong_email@gmail.com"
      log_in(user_info) 
      expect(page).to have_css('p.alert', :text => 'Invalid Email or password.')
    end
  end

  context "when password is incorrect" do
    scenario 'stays on sign-in page' do
      user_info.password = "wrongpassword"
      log_in(user_info)
      expect(current_path).to eq("/users/sign_in")
      expect(page).to have_css('h1', :text => 'Log in')
    end
    scenario "returns error alert" do
      user_info.password = "wrongpassword"
      log_in(user_info)
      expect(page).to have_css('p.alert', :text => 'Invalid Email or password.')
    end
  end
end