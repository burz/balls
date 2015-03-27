class InviteMailer < ApplicationMailer
  default from: 'invites@ballsapp.com'

  def invite_email user, email, league, token
    @email = email
    @league = league
    @token = token
    @subject = user.name + ' (' + user.email +
               ') has invited you to "' + league.name + '"'
    mail to: email, subject: @subject
  end
end
