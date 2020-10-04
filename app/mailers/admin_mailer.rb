class AdminMailer < ApplicationMailer 
  default from: 'admin@thuy.life'
  default to: 'admin@thuy.life'

  def admin_approval_email
    mail(
      subject: 'User awaiting Administrator Approval')
  end
end

