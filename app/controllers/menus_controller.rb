class MenusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if @current_user
      render "index"
    else
      render "menu_list"
    end
  end

  def show
    @menuitem = Menuitem.find(params[:id])
    render "show"
  end

  def create
    name = params[:name]
    Menu.create!(name: name, activemenu: false)
    redirect_to menus_path
  end

  def update
    id = params[:id]
    menu_name = params[:menu_name]
    menu = Menu.find_by(name: menu_name)
    menu_change = Menu.find_by(activemenu: true)
    if menu_change
      menu_change.activemenu = false
      menu_change.save!
    end
    menu.activemenu = true
    menu.save!
    redirect_to menus_path
  end
end
