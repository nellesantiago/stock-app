class UserStocksController < ApplicationController
  before_action :authenticate_user!

  # GET /user_stocks or /user_stocks.json
  def index
    @user_stocks = current_user.user_stocks
  end

  # GET /user_stocks/1 or /user_stocks/1.json
  def show
    @user_stock = current_user.user_stocks.find(params[:id])
  end

end
