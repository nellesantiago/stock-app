class DashboardController < ApplicationController
    def index
        @user_stocks = current_user.user_stocks
    @transactions = current_user.transactions
    @stocks = Stock.all
    @card_number = 4.times.map {rand(1..9)}
    @client = IEX::Api::Client.new
    @index = [4, 16, 13, 12]
    end
end