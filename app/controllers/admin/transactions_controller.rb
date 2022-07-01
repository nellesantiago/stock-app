class Admin::TransactionsController < ApplicationController
    before_action :verify_role
    def index
        @transactions = Transaction.all
    end

private

    def verify_role
        if current_user.admin?
            return
        else
            redirect_to stocks_path
        end
    end

end