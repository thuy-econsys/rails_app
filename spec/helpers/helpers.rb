module TestHelper
  def sign_up(user)
    visit new_user_registration_path
    expect(current_path).to eq('/users/sign_up')
    expect(page).to have_content('Sign up')
    fill_in(:user_email, :with => test_user[:email])
    fill_in(:user_password, :with => test_user[:password])
    fill_in(:user_password_confirmation, :with => test_user[:password_confirmation])
    # fill_in(:user_email, :with => password_not_a_match[:email])
    # fill_in(:user_password, :with => password_not_a_match[:password])
    # fill_in(:user_password_confirmation, :with => password_not_a_match[:password_confirmation])
    click_button('Sign up')
  end

  def log_in(user)
    visit new_user_session_path
    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_content('Log in')
    fill_in(:user_email, :with => user.email)
    fill_in(:user_password, :with => user.password)
    click_button('Log in')
  end
end