class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :verify_role

  # GET /users or /users.json
  def index
    @users = User.where(role: 'trader')
    @client = IEX::Api::Client.new
    @index = [6, 18, 16, 15]
    @stocks = Stock.all
    @highest_trader = get_highest('order_quantity')
    @highest_shares_bought = @highest_trader[0]
    @top_trader = User.find(@highest_trader[1])
    @top_trader_name = @top_trader.first_name + " " + @top_trader.last_name
    @highest_spender =  get_highest('total_stock_price')
    @amount_spent = @highest_spender[0]
    @top_spender = User.find(@highest_spender[1])
    @top_spender_name = @top_spender.first_name + " " + @top_spender.last_name
    @richest_trader = @users.each.pluck(:balance, :id).max
    @highest_balance = @richest_trader[0]
    @richest_trader = User.find(@richest_trader[1])
    @richest_trader_name = @richest_trader.first_name + " " + @richest_trader.last_name
  end

  # GET /users/1 or /users/1.json
  def show
    @user_stocks = @user.user_stocks
    @transactions = @user.transactions
    @stocks = Stock.all
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
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

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      UserMailer.with(user: @user).welcome_email.deliver_now
      redirect_to users_path, notice: "User was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    UserMailer.with(user: @user).declined_account.deliver_now
    @user.destroy
    redirect_to users_path, notice: "User was successfully deleted."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
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

    def get_highest(attr)
      @users.joins(:user_stocks).group('user_id').pluck("sum(user_stocks.#{attr})", "user_stocks.user_id").max
    end
end
