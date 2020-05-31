class OrderMailer < ActionMailer::Base
  default :from => "maharajarestaurant.service@gmail.com"

  def order_confirmation(user, order)
    @user = user
    @order = order
    mail(:to => "#{user.email_id}", :subject => "Order Confirmation")
  end
end
