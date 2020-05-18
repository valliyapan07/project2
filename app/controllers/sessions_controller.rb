class SessionsController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
  end

  def create
    user = User.find_by(email_id: params[:email])
    if user && user.authenticate(params[:password])
      if user.email_confirmed
        session[:current_user_id] = user.id
        flash[:notice] = user.first_name + ", you have successfully signed in."
        redirect_to menus_path
      else
        flash[:error] = "Verify your mail to sign in!"
        redirect_to new_sessions_path
      end
    else
      flash[:error] = "Your login attempt was invalid. Please retry."
      redirect_to new_sessions_path
    end
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    flash[:notice] = "Successfully signed out."
    redirect_to "/"
  end
end
