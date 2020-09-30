module TestHelper
  def log_in(user)
    visit new_user_session_path
    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_content("Log in")
    fill_in(:user_email, :with => user[:email])
    fill_in(:user_password, :with => user[:password])
    click_button('Log in')
  end  
end