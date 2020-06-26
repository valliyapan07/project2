class MenusController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if @owner
      render "menu_list"
    else
      render "index"
    end
  end

  def show
    @menuitem = Menuitem.find(params[:id])
    render "show"
  end

  def create
    name = params[:name]
    menu = Menu.new(name: name, activemenu: false)
    if menu.save
      flash[:notice] = "Menu added successfully"
      redirect_to menus_path
    else
      flash[:error] = menu.errors.full_messages.join(", ")
      redirect_to menuitems_path
    end
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

  def destroy
    id = params[:id]
    menu = Menu.find(id)
    flash[:notice] = "#{menu.name} deleted successfully"
    menuitems = menu.menuitems
    menuitems.delete
    menu.delete
    redirect_to menus_path
  end
end
