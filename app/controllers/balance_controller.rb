class BalanceController < ApplicationController
    # before_action :authenticate_user!

    def edit
        @user = current_user
    end

    def update
        @user = current_user
        @user.balance += balance_param[:balance].to_d
        @user.save
        redirect_to user_stocks_path
    end

private
    def balance_param
        params.require(:user).permit(:balance)
    end
end