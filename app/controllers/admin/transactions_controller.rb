class Admin::TransactionsController < ApplicationController
    before_action :verify_role
    def index
        @transactions = Transaction.all
        @stocks = Stock.all
    end

private

    def verify_role
        if current_user.admin?
            return
        else
            redirect_to user_stocks_path, alert: "Function is only for admin!"
        end
    end

end