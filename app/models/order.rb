class Order < ActiveRecord::Base
  has_many :orderitems
  belongs_to :user

  def ist(time)
    time.in_time_zone(TZInfo::Timezone.get("Asia/Kolkata")).to_s(:short)
  end

  def self.display(from, to, filter)
    if filter == "DP" || filter == nil
      Order.all.where("ordered_at > ? and ordered_at < ?", from, to)
    elsif filter == "P"
      orders = Order.all.where("ordered_at > ? and ordered_at < ?", from, to)
      orders.all.where(delivered_at: nil)
    else
      Order.all.where("ordered_at > ? and ordered_at < ? and delivered_at < ?", from, to, Date.today + 1)
    end
  end

  def show_name
    user = User.find(user_id)
    user.first_name + " " + user.last_name
  end

  def self.total(id)
    order = Order.find(id)
    sum = 0
    order.orderitems.each do |item|
      sum = sum + (item.menuitem_price * item.menuitem_quantity)
    end
    sum
  end
end
