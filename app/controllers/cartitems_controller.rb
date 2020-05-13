class CartitemsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @cartitems = current_user.cartitems
    if @cartitems.count != 0
      render "index"
    else
      redirect_to menus_path
    end
  end

  def create
    menuitem_id = params[:id]
    menuitem = Menuitem.find(menuitem_id)
    quantity = params[:quantity]
    cart = current_user.cartitems.new(name: menuitem.name,
                                      price: menuitem.price,
                                      quantity: quantity,
                                      menuitem_id: menuitem_id,
                                      user_id: @current_user.id)
    if quantity.to_i != 0
      cart.save!
      flash[:notice] = menuitem.name + " is added to cart."
      redirect_to menus_path
    else
      flash[:error] = "Quantity cannot be zero"
      redirect_to menus_path
    end
  end

  def update
    cartitems = current_user.cartitems.find(params[:id])
    cartitems.quantity = params[:quantity]
    if cartitems.quantity.to_i != 0
      cartitems.save!
      redirect_to cartitems_path
    else
      cartitems.destroy
      redirect_to cartitems_path
    end
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
