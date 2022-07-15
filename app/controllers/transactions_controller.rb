class TransactionsController < ApplicationController
  before_action :verify_role

  def index
    @transactions = current_user.transactions
    @stocks = Stock.all
    @total_shares_sold = @transactions.group('transaction_type').sum('order_quantity')["sell"] || 0
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
      update_balance
      redirect_to user_stocks_path
    end
    rescue ActiveRecord::RecordInvalid
    redirect_to request.referrer, alert: "#{@user_stock.errors.full_messages.to_sentence}#{current_user.errors.full_messages.to_sentence}"
  end

  private

    def transaction_params
      params.require(:transaction).permit(:transaction_type, :stock_symbol, :company_name, :order_quantity, :stock_price)
    end

    def update_user_stocks
      @user_stock = current_user.user_stocks.find_or_initialize_by(stock_symbol: @transaction.stock_symbol)

      if @transaction.transaction_type_sell?
        @user_stock.update!(order_quantity: @user_stock.order_quantity.to_i + (@transaction.order_quantity.to_i * -1)) 
        @user_stock.clear_stock
      end

      @user_stock.update!(
        company_name: @transaction.company_name,
        order_quantity: @user_stock.order_quantity.to_i + @transaction.order_quantity.to_i
      ) if @transaction.transaction_type_buy?

    end

    def update_balance
      current_user.update!(balance: current_user.balance.to_d - @transaction.total_stock_price.to_d) if @transaction.transaction_type_buy?
      current_user.update!(balance: current_user.balance.to_d + @transaction.total_stock_price.to_d) if @transaction.transaction_type_sell?
    end

    def verify_role
      if current_user.approved? && current_user.trader?
        return
      else
        redirect_to user_stocks_path, alert: "Wait for admin approval"
      end
    end
end
