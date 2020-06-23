class PendingordersController < ApplicationController
  def index
    @from = session[:from_date]
    @to = session[:to_date]
    @filter = "P"
    render "index"
  end

  def show
    if params[:from_date] == "" || params[:to_date] == ""
      flash[:error] = "Start Date or End Date Should not be empty!!"
    elsif params[:from_date] > params[:to_date]
      flash[:error] = "Enter a valid date!!"
    end
    session[:from_date] = params[:from_date]
    session[:to_date] = params[:to_date]
    redirect_to controller: "pendingorders", action: "index"
  end
end
