class UserMailer < ApplicationMailer
  default from: 'austin@isawesome.com'

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000'
    mail(to: @user.email, subject: 'Thanks for signing the fuck up brobowski')
  end
end
