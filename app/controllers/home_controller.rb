class HomeController < ApplicationController
  skip_before_action :ensure_user_logged_in

  def index
    if @current_user && @current_user.email_confirmed
      redirect_to menus_path
    else
      render "index"
    end
  end
end
