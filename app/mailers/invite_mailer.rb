class InviteMailer < ApplicationMailer
  default from: 'invites@ballsapp.com'

  def invite_email user, email, league, token
    @user = user
    @email = email
    @league = league
    @token = token
    subject = user.name + ' has invited you to join the ' +
              league.name + ' beer pong league'
    mail to: email, subject: subject
  end
end
