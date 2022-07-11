class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  before_action :verify_role

  # GET /users or /users.json
  def index
    @users = User.where(role: 'trader')
  end

  # GET /users/1 or /users/1.json
  def show
    @user_stocks = @user.user_stocks
    @transactions = @user.transactions
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
    redirect_to users_path, notice: "User was successfully destroyed."
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
        redirect_to user_stocks_path, alert: "Function is only for admin"
      end
    end
end
