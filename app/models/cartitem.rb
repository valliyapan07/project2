class Cartitem < ActiveRecord::Base
  belongs_to :user
  belongs_to :menuitem

  def self.total(id)
    cartitems = Cartitem.find(id)
    cartitems.price * cartitems.quantity
  end

  def self.sum(cartitems)
    sum = 0
    cartitems.all.each do |t|
      sum += (t.price * t.quantity)
    end
    sum
  end

  def self.empty()
    if Cartitem.all == []
      return true
    else
      return false
    end
  end
end
