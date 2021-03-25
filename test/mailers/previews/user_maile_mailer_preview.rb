# Preview all emails at http://localhost:3000/rails/mailers/user_maile_mailer
class UserMaileMailerPreview < ActionMailer::Preview

  def user_mail_preview
    UserMaileMailer.with(
      requested_slots: [RequestedSlot.first, RequestedSlot.last],
      to:              'up694452@myport.ac.uk').prayer_confirmation_email
  end

end
