require 'rails_helper'

feature 'User login' do
  let!(:unapproved_and_confirmed_user) { create(:unapproved_confirmed_user) }
  let!(:approved_and_confirmed_user) { create(:approved_confirmed_user) }

  scenario 'is able to visit new_user_session_path' do
    visit new_user_session_path
    expect(current_path).to eq('/account/sign_in')
    expect(page).to have_css('h1', :text => 'Log in')
  end
  
  context "when user is approved and email is confirmed" do
    scenario "redirects to home page" do
      log_in(approved_and_confirmed_user)
      expect(current_path).to eq("/")
    end
    scenario "has successful sign-in notice" do
      log_in(approved_and_confirmed_user)
      expect(page).to have_css('p.notice', :text => 'Signed in successfully.')
    end
    scenario "has correct content" do
      log_in(approved_and_confirmed_user)
      expect(page).to have_css('h1', :text => 'Home Page' )
    end
  end

  context "when user is unapproved but email is confirmed" do
    scenario "stays on the sign-in page" do
      log_in(unapproved_and_confirmed_user)
      expect(current_path).to eq("/account/sign_in")
    end
    scenario "returns alert of pending admin approval" do
      log_in(unapproved_and_confirmed_user)
      expect(page).to have_css('p.alert', :text => 'Your account has not been approved by your administrator yet.')
    end
    scenario "has correct content" do
      log_in(unapproved_and_confirmed_user)
      expect(page).to have_css('h1', :text => 'Log in')
    end
  end

  context "when email is incorrect" do
    scenario "stays on sign-in page" do
      approved_and_confirmed_user.email = "wrong_email@gmail.com"
      log_in(approved_and_confirmed_user)
      expect(current_path).to eq("/account/sign_in")
      expect(page).to have_css('h1', :text => 'Log in')
    end
    scenario "returns error alert" do
      approved_and_confirmed_user.email = "wrong_email@gmail.com"
      log_in(approved_and_confirmed_user) 
      expect(page).to have_css('p.alert', :text => 'Invalid Email or password.')
    end
  end

  context "when password is incorrect" do
    scenario 'stays on sign-in page' do
      approved_and_confirmed_user.password = "wrongpassword"
      log_in(approved_and_confirmed_user)
      expect(current_path).to eq("/account/sign_in")
      expect(page).to have_css('h1', :text => 'Log in')
    end
    scenario "returns error alert" do
      approved_and_confirmed_user.password = "wrongpassword"
      log_in(approved_and_confirmed_user)
      expect(page).to have_css('p.alert', :text => 'Invalid Email or password.')
    end
  end
end