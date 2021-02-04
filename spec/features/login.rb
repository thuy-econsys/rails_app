require 'rails_helper'

feature 'User login' do
  let!(:unapproved_user) { create(:user) }
  let!(:approved_user) { create(:approved_user) }

  scenario 'is able to visit new_user_session_path' do
    visit new_user_session_path
    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_css('h1', :text => 'Log in')
  end
  
  context "when user is approved" do
    scenario "redirects to home page" do
      log_in(approved_user)
      expect(current_path).to eq("/")
    end
    scenario "has successful sign-in notice" do
      log_in(approved_user)
      expect(page).to have_css('p.notice', :text => 'Signed in successfully.')
    end
    scenario "has correct content" do
      log_in(approved_user)
      expect(page).to have_css('h1', :text => 'Home Page' )
    end
  end

  context "when user is unapproved" do
    scenario "stays on the sign-in page" do
      log_in(unapproved_user)
      expect(current_path).to eq("/users/sign_in")
    end
    scenario "returns alert of pending admin approval" do
      log_in(unapproved_user)
      expect(page).to have_css('p.alert', :text => 'Your account has not been approved by your administrator yet.')
    end
    scenario "has correct content" do
      log_in(unapproved_user)
      expect(page).to have_css('h1', :text => 'Log in')
    end
  end

  context "when email is incorrect" do
    scenario "stays on sign-in page" do
      approved_user.email = "wrong_email@gmail.com"
      log_in(approved_user)
      expect(current_path).to eq("/users/sign_in")
      expect(page).to have_css('h1', :text => 'Log in')
    end
    scenario "returns error alert" do
      approved_user.email = "wrong_email@gmail.com"
      log_in(approved_user) 
      expect(page).to have_css('p.alert', :text => 'Invalid Email or password.')
    end
  end

  context "when password is incorrect" do
    scenario 'stays on sign-in page' do
      approved_user.password = "wrongpassword"
      log_in(approved_user)
      expect(current_path).to eq("/users/sign_in")
      expect(page).to have_css('h1', :text => 'Log in')
    end
    scenario "returns error alert" do
      approved_user.password = "wrongpassword"
      log_in(approved_user)
      expect(page).to have_css('p.alert', :text => 'Invalid Email or password.')
    end
  end
end