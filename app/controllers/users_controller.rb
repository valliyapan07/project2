class UsersController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def new
    render "users/new"
  end

  def index
    if session[:user]
      name = session[:user].split(" ")
      name[1] = name[1] ? name[1] : ""
      @users = User.all.find_by("first_name = ? and last_name = ?", name[0], name[1])
    else
      @users = session[:user]
    end
    current_user
    render "search"
  end

  def select
    session[:user] = params[:user_name]
    redirect_to users_path
  end

  def update
    session[:clerk] = params[:user_name]
    redirect_to controller: "users", action: "show"
  end

  def create
    if (@owner)
      user = User.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email_id: params[:email],
        role: "Bill Checker",
        password: params[:password],
      )
      redirect_to controller: "users", action: "show"
    else
      user = User.new(
        first_name: params[:first_name],
        last_name: params[:last_name],
        email_id: params[:email],
        password: params[:password],
        role: "User",
      )
    end
    if user.save
      session[:current_user_id] = user.id
      flash[:notice] = user.first_name + ", we have sent you a mail. Please click on the link to verify!"
      UserMailer.registration_confirmation(user).deliver
      redirect_to new_user_path
    else
      flash[:error] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:notice] = user.first_name + ", you have successfully signed in!"
      redirect_to menus_path
    else
      flash[:error] = "Sorry. User does not exist"
      redirect_to "/"
    end
  end

  def show
    if session[:clerk]
      name = session[:clerk].split(" ")
      name[1] = name[1] ? name[1] : ""
      @users = User.all.find_by("first_name = ? and last_name = ?", name[0], name[1])
    else
      @users = session[:clerk]
    end
    current_user
    render "checkers"
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to controller: "users", action: "show"
  end

  def hold
    if params[:from_date] == "" || params[:to_date] == ""
      flash[:error] = "Start Date or End Date Should not be empty!!"
    elsif params[:from_date] > params[:to_date]
      flash[:error] = "Enter a valid date!!"
    end
    session[:from_date] = params[:from_date]
    session[:to_date] = params[:to_date]
    redirect_to report_path
  end

  def edit
    if session[:user]
      name = session[:user].split(" ")
      name[1] = name[1] ? name[1] : ""
      @users = User.all.find_by("first_name = ? and last_name = ?", name[0], name[1])
      @from = session[:from_date]
      @to = session[:to_date]
    else
      @users = session[:user]
    end
    render "report"
  end
end
