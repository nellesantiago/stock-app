class UserStocksController < ApplicationController
  before_action :verify_role

  def index
    @user_stocks = current_user.user_stocks
    @stocks = Stock.all
    @transactions = current_user.transactions
    @total_spent = get_total_spent
    @highest_bought = get_highest_stock_bought
  end

  private

  def verify_role 
    if current_user.trader?
      return
    else
      redirect_to users_path, alert: "Function is only for traders!"
    end
  end

  def get_total_spent
    current_user.transactions.group('transaction_type').sum('total_stock_price')['buy']
  end

  def get_highest_stock_bought
    current_user.transactions.group('transaction_type').maximum('order_quantity')['buy']
  end

end
