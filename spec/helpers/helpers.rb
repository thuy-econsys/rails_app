module TestHelper
  def sign_up(user)
    visit new_user_registration_path
    fill_in(:user_email, :with => user[:email])
    fill_in(:user_phone, :with => user[:phone])
    fill_in(:user_password, :with => user[:password])
    fill_in(:user_password_confirmation, :with => user[:password_confirmation])
    fill_in(:user_notes, :with => user[:notes])
    click_button('Sign up')
  end

  def log_in(user)
    visit new_user_session_path
    fill_in(:user_email, :with => user.email)
    fill_in(:user_password, :with => user.password)
    click_button('Log in')
  end
end