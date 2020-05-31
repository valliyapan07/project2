class ApplicationController < ActionController::Base
  before_action :ensure_user_logged_in

  def ensure_user_logged_in
    unless current_user
      redirect_to "/"
    end
  end

  def current_user
    return @current_user if @current_user

    current_user_id = session[:current_user_id]
    if current_user_id
      if User.find(current_user_id).role == "Billing clerk"
        @current_user = User.find_by first_name: "Walk-incustomer"
        @current_billingclerk = User.find(current_user_id)
      else
        @current_user = User.find(current_user_id)
      end
    else
      nil
    end
  end

  def selected_menu
    return @current_menu if @current_menu
    if session[:menu]
      @current_menu = session[:menu]
    else
      @current_menu = Menu.first.name
    end
  end
end
