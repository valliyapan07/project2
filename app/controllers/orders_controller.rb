class OrdersController < ApplicationController
  def create
    @order = Order.create!(ordered_at: DateTime.now, user_id: @current_user.id)
    @current_user.cartitems.all.each do |t|
      Orderitem.create!(order_id: @order.id,
                        menuitem_id: t.menuitem_id,
                        menuitem_name: t.name,
                        menuitem_price: t.price,
                        menuitem_quantity: t.quantity
                      )
    end
    @current_user.cartitems.destroy_all
    flash[:notice] = "Thanks for Buying " + @current_user.first_name + "!"
    redirect_to userhome_index_path
  end

  def hold1
    if params[:from_date] == "" || params[:to_date] == ""
      flash[:error] = "Start Date or End Date Should not be empty!!"
    elsif params[:from_date] > params[:to_date]
      flash[:error] = "Enter a valid date!!"
    end
    session[:filter] = "DP"
    session[:from_date] = params[:from_date]
    session[:to_date] = params[:to_date]
    redirect_to users_path
  end

  def index
    @from = session[:from_date]
    @to = session[:to_date]
    @filter = session[:filter]
    render "order"
  end

  def hold
    if params[:from_date] == "" || params[:to_date] == ""
      flash[:error] = "Start Date or End Date Should not be empty!!"
    elsif params[:from_date] > params[:to_date]
      flash[:error] = "Enter a valid date!!"
    end
    session[:from_date] = params[:from_date]
    session[:to_date] = params[:to_date]
    redirect_to orders_path
  end

  def select
    session[:filter] = params[:filter]
    redirect_to orders_path
  end

  def update
    status = params[:delivered]
    id = params[:id]
    order = Order.find(id)
    if status
      order.delivered_at = DateTime.now
    else
      order.delivered_at = nil
    end
    order.save
    if @current_billingclerk
      flash[:notice] = "Order Id #{id} is delivered"
      redirect_to controller: "pendingorders", action: "index"
    else
      redirect_to orders_path
    end
  end
end
