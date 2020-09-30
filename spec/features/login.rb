require 'rails_helper'

feature 'User login' do
  let!(:user_info) { create(:user) }

  context "when login is successful" do
    scenario "redirects to home page" do
      log_in(user_info)
      expect(current_path).to eq("/")
    end
    scenario "returns successful sign-in message" do
      log_in(user_info)
      expect(page).to have_content("Signed in successfully.")
    end
    scenario "has correct content" do
      log_in(user_info)
      expect(page).to have_content("Home Page")
    end
  end

  context "when email is incorrect" do
    scenario "redirects to sign-in page" do
      user_info.email = "wrong_email@gmail.com"
      log_in(user_info) 
      expect(current_path).to eq("/users/sign_in")  
    end
    scenario "returns error message" do
      user_info.email = "wrong_email@gmail.com"
      log_in(user_info) 
      expect(page).to have_content("Invalid Email or password.")
    end
  end

  context "when password is incorrect" do
    scenario 'redirects to sign-in page' do
      user_info.password = "wrongpassword"
      log_in(user_info)
      expect(current_path).to eq("/users/sign_in")
    end
    scenario "returns error message" do
      user_info.password = "wrongpassword"
      log_in(user_info)
      expect(page).to have_content("Invalid Email or password.")
    end
  end
end