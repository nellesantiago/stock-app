class StocksController < ApplicationController

  # GET /stocks or /stocks.json
  def index
    @stocks = Stock.all
  end

  # GET /stocks/1 or /stocks/1.json
  def show
    @stock = Stock.find(params[:id])
  end

  def home
  end

end
