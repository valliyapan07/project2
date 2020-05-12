class CartitemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @cartitems = current_user.cartitems
    render "index"
  end

  def create
    menuitem_id = params[:id]
    menuitem = Menuitem.find(menuitem_id)
    quantity = params[:quantity]
    current_user.cartitems.create!(name: menuitem.name,
                                   price: menuitem.price,
                                   quantity: quantity,
                                   menuitem_id: menuitem_id,
                                   user_id: @current_user.id)
    flash[:notice] = menuitem.name + " is added to cart."
    redirect_to menus_path
  end

  def update
    cartitems = current_user.cartitems.find(params[:id])
    cartitems.quantity = params[:quantity]
    cartitems.save!
    redirect_to cartitems_path
  end

  def destroy
    cartitems = current_user.cartitems.find(params[:id])
    cartitems.destroy
    redirect_to cartitems_path
  end

  def deleteall
    current_user.cartitems.destroy_all
    redirect_to menus_path
  end
end
