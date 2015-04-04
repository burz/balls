class WelcomeMailer < ApplicationMailer
  default from: 'welcome@ballsapp.com'

  def welcome_email user
    @user = user
    mail to: @user.email, subject: 'Welcome to BallsApp!'
  end
end
