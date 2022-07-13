class StocksController < ApplicationController
  before_action :verify_status, only: %i[show]

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
end
