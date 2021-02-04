class AdminMailer < ApplicationMailer 
  default from: 'admin@thuy.life'
  
  def admin_approval_email
    mail(
      to: params[:user].email,
      cc: 'admin@thuy.life',
      subject: 'Thank you for signing up')
  end
end

