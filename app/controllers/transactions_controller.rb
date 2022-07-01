class TransactionsController < ApplicationController
  before_action :authenticate_user!

  def index
    @transactions = current_user.transactions
  end

  def new
    @transaction = current_user.transactions.build
    @user = current_user
    @user_stock = current_user.user_stocks.find_by(stock_symbol: params[:stock_symbol])
    @stock = Stock.find_by(symbol: params[:stock_symbol])
  end

  def create
    ActiveRecord::Base.transaction do
      @transaction = current_user.transactions.create(transaction_params)
      update_user_stocks
      redirect_to user_stocks_path
    end
    rescue ActiveRecord::RecordInvalid
    redirect_to request.referrer, alert: "#{@user_stock.errors.full_messages[0]}"
  end

  private

    def transaction_params
      params.require(:transaction).permit(:transaction_type, :stock_symbol, :company_name, :order_quantity, :stock_price)
    end

    def update_user_stocks
      @user_stock = current_user.user_stocks.find_or_initialize_by(stock_symbol: @transaction.stock_symbol)

      @user_stock.update!(
        order_quantity: @user_stock.order_quantity + (@transaction.order_quantity * -1)
      ) if @transaction.transaction_type_sell?

      @user_stock.update!(
        company_name: @transaction.company_name,
        stock_price: @transaction.stock_price,
        order_quantity: @user_stock.order_quantity.to_i + @transaction.order_quantity.to_i
      ) if @transaction.transaction_type_buy?
    end
end
