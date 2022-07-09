class UserStocksController < ApplicationController
  before_action :verify_role

  # GET /user_stocks or /user_stocks.json
  def index
    @user_stocks = current_user.user_stocks
    @stocks = Stock.all
    @transactions = current_user.transactions
  end

  # GET /user_stocks/1 or /user_stocks/1.json
  def show
    @user_stock = current_user.user_stocks.find(params[:id])
  end

  private

  def verify_role 
    if current_user.trader?
      return
    else
      redirect_to users_path, alert: "Function is only for traders"
    end
  end

end
