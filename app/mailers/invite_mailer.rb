class InviteMailer < ApplicationMailer
  default from: 'invites@ballsapp.com'

  def invite_email user, email, league
    @email = email
    @league = league
    @token = "019bb34"
    @subject = user.email + " has invited you to \"" + league.name + '"'
    mail to: email, subject: @subject
  end
end
