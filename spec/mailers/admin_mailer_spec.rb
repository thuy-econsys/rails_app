require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe AdminMailer, type: :mailer do
  let(:test_user) { create(:user) }
  
  # FIXME no jobs in queue
  it 'mailer job is created' do
    expect {
      AdminMailer.with(user: test_user).admin_approval_email.deliver
    }.to have_enqueued_job.on_queue('mailers')
  end
end