class MenuitemsController < ApplicationController
  def index
    @menus = Menu.find_by(name: selected_menu)
    @menuitems = Menuitem.find_by(name: selected_menuitem)
    render "menu"
  end

  def edit
    session[:menu] = params[:menu_name]
    redirect_to menuitems_path
  end

  def create
    menu_name = params[:name]
    id = Menu.find_by(name: menu_name).id
    menuitem_name = params[:menuitem_name]
    description = params[:description]
    price = params[:price]
    category_name = params[:category_name]
    img_addr = params[:img_addr]
    menuitem = Menuitem.new(menu_id: id,
                            name: menuitem_name,
                            description: description,
                            price: price,
                            category_name: category_name,
                            imgaddr: img_addr)
    if menuitem.save
      flash[:notice] = "Menuitem added successfully"
      redirect_to menus_path
    else
      flash[:error] = menuitem.errors.full_messages.join(", ")
      redirect_to menuitems_path
    end
  end

  def destroy
    id = params[:id]
    menu_item = Menuitem.find_by(id: id)
    menu_item.destroy
    redirect_to menus_path
  end

  def update
    menu_id = params[:id]
    array = params[:menuitem_name].split("/")
    menuitem_name = array[0]
    category = array[1]
    price = params[:price]
    menuitem = Menuitem.find_by("menu_id = ? and name = ? and category_name = ? ", menu_id, menuitem_name, category)
    menuitem.price = price
    menuitem.save!
    redirect_to menus_path
  end
end
