class StocksController < ApplicationController
  before_action :verify_status, only: %i[show]
  before_action :redirect, only: %i[home]

  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
  end

  def home
  end

  private

  def verify_status
    if current_user.approved? && current_user.trader?
      return
    else
      redirect_to user_stocks_path, alert: "Wait for admin approval"
    end
  end

  def redirect 
    if user_signed_in?
      redirect_to dashboard_path
    end
  end
end
