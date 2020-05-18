class UserMailer < ActionMailer::Base
  default :from => "maharajarestaurant.service@gmail.com"

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.email_id}", :subject => "Registration Confirmation")
  end
end
