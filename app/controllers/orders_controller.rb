class OrdersController < ApplicationController
  def create
    order = Order.create!(ordered_at: DateTime.now, user_id: @current_user.id)
    Cartitem.all.each do |t|
      Orderitem.create!(order_id: order.id,
                        menuitem_id: t.menuitem_id,
                        menuitem_name: t.name,
                        menuitem_price: t.price,
                        menuitem_quantity: t.quantity)
    end
    @current_user.cartitems.destroy_all
    flash[:notice] = "Thanks for Buying " + @current_user.first_name + "!"
    redirect_to userhome_index_path
  end
end
