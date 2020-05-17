class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def create
    user = User.new(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email_id: params[:email],
      password: params[:password],
    )
    if user.save
      session[:current_user_id] = user.id
      flash[:notice] = user.first_name + ", you have successfully signed in!"
      redirect_to menus_path
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end
end
