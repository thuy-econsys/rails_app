require 'rails_helper'

feature 'User login' do
  let!(:unapproved_user) { create(:user) }
  let!(:approved_user) { create(:approved_user) }

  context "when user is approved" do
    scenario "redirects to home page" do
      log_in(approved_user)
      expect(current_path).to eq("/")
    end
    scenario "returns successful sign-in message" do
      log_in(approved_user)
      expect(page).to have_content("Signed in successfully.")
    end
    scenario "has correct content" do
      log_in(approved_user)
      expect(page).to have_content("Home Page")
    end
  end

  context "when user is unapproved" do
    scenario "stays on the Log in page" do
      log_in(unapproved_user)
      expect(current_path).to eq("/users/sign_in")
    end
    scenario "returns alert of pending admin approval" do
      log_in(unapproved_user)
      expect(page).to have_content("Your account has not been approved by your administrator yet.")
    end
    scenario "has correct content" do
      log_in(unapproved_user)
      expect(page).to have_content("Log in")
    end
  end

  context "when email is incorrect" do
    scenario "redirects to sign-in page" do
      approved_user.email = "wrong_email@gmail.com"
      log_in(approved_user) 
      expect(current_path).to eq("/users/sign_in")  
    end
    scenario "returns error message" do
      approved_user.email = "wrong_email@gmail.com"
      log_in(approved_user) 
      expect(page).to have_content("Invalid Email or password.")
    end
  end

  context "when password is incorrect" do
    scenario 'redirects to sign-in page' do
      approved_user.password = "wrongpassword"
      log_in(approved_user)
      expect(current_path).to eq("/users/sign_in")
    end
    scenario "returns error message" do
      approved_user.password = "wrongpassword"
      log_in(approved_user)
      expect(page).to have_content("Invalid Email or password.")
    end
  end
end