class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :verify_role

  # GET /users or /users.json
  def index
    @users = User.where(role: 'trader')
    @client = IEX::Api::Client.new
    @index = [6, 18, 16, 15]
    @stocks = Stock.all
    
    @highest_trade = get_top_trade
    if !@highest_trade.nil?
      @highest_shares_bought = @highest_trade[0]
      @top_trader = User.find(@highest_trade[1])
      @top_trader_name = get_name(@top_trader)
    else
      @highest_shares_bought = 0
      @top_trader = User.find_by(role: "admin")
      @top_trader_name = "None"
    end
    
    @highest_spent = get_top_spent
    if !@highest_spent.nil?
      @amount_spent = @highest_spent[0]
      @top_spender = User.find(@highest_spent[1][0])
      @top_spender_name = get_name(@top_spender)
    else
      @amount_spent = 0
      @top_spender = User.find_by(role: "admin")
      @top_spender_name = "None"
    end
    
    @richest_trader = @users.each.pluck(:balance, :id).max
    if !@richest_trader.nil?
      @highest_balance = @richest_trader[0]
      @richest_trader = User.find(@richest_trader[1])
      @richest_trader_name = get_name(@richest_trader)
    else
      @highest_balance = 0
      @richest_trader = User.find_by(role: "admin")
      @richest_trader_name = "None"
    end
  end

  def show
    @user_stocks = @user.user_stocks
    @transactions = @user.transactions
    @stocks = Stock.all
    @total_spent = get_total_spent || 0
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    @user.status = 'approved'
    @user.skip_confirmation!
    if @user.save
      UserMailer.with(user: @user).welcome_email.deliver_now
      redirect_to users_path, notice: "User was successfully created."
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      UserMailer.with(user: @user).welcome_email.deliver_now
      redirect_to users_path, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    UserMailer.with(user: @user).declined_account.deliver_now
    @user.destroy
    redirect_to users_path, notice: "User was successfully deleted."
  end

  private

    def set_user
      @user = User.find(params[:id])
    end


    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :status, :first_name, :last_name)
    end

    def verify_role
      if current_user.admin?
        return
      else
        redirect_to user_stocks_path, alert: "Function is only for admin!"
      end
    end

    def get_top_trade
      UserStock.group('user_id').sum('order_quantity').invert.max
    end

    def get_top_spent
      Transaction.group('user_id').group('transaction_type').sum('total_stock_price').invert.max 
    end

    def get_name(user)
      user.first_name + " " + user.last_name
    end

    def get_total_spent
      User.find(params[:id]).transactions.group('transaction_type').sum('total_stock_price')['buy']
    end
end
