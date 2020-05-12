class MenusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render "index"
  end

  def show
    @menuitem = Menuitem.find(params[:id])
    #render "show"
  end
end
