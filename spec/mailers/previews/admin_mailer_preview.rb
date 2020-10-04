# http://localhost:3000/rails/mailers/admin_mailer/mailer_preview
class AdminMailerPreview < ActionMailer::Preview
  def admin_mailer_preview
    AdminMailer.with(user: User.first).admin_approval_email
  end
end
