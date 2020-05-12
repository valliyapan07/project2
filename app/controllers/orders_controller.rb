class OrdersController < ApplicationController
  def create
    order = Order.create!(date: DateTime.now, user_id: @current_user.id)
    Cartitem.all.each do |t|
      Orderitem.create!(order_id: order.id,
                        menu_item_id: t.menuitem_id,
                        menu_item_name: t.name,
                        menu_item_price: t.price,
                        menu_item_quantity: t.quantity)
    end
  end
end
