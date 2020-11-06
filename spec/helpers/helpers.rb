module TestHelper
  def sign_up(user)
    visit new_user_registration_path
    expect(current_path).to eq('/users/sign_up')
    expect(page).to have_css('h1', :text => 'Sign up')
    fill_in(:user_email, :with => user[:email])
    fill_in(:user_phone, :with => user[:phone])
    fill_in(:user_password, :with => user[:password])
    fill_in(:user_password_confirmation, :with => user[:password_confirmation])
    click_button('Sign up')
  end

  def log_in(user)
    visit new_user_session_path
    expect(current_path).to eq('/users/sign_in')
    expect(page).to have_css('h1', :text => 'Log in')
    fill_in(:user_email, :with => user.email)
    fill_in(:user_password, :with => user.password)
    click_button('Log in')
  end
end