class DashboardController < ApplicationController
    before_action :verify_role
    def index
        @user_stocks = current_user.user_stocks
        @transactions = current_user.transactions
        @stocks = Stock.all
        @card_number = 4.times.map {rand(1..9)}
        @client = IEX::Api::Client.new
        @index = [6, 18, 16, 15]
    end

    private

    def verify_role
        if current_user.trader?
            return
        else
            redirect_to users_path, alert: "Function is only for traders"
        end
    end
end