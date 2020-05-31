class Orderitem < ActiveRecord::Base
  belongs_to :order
  belongs_to :menuitem

  def total
    menuitem_price * menuitem_quantity
  end
end
