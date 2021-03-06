# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create(
    email: Rails.application.credentials.admin_email,
    password: Rails.application.credentials.admin_password,
    password_confirmation: Rails.application.credentials.admin_password,
    role: 'admin',
    status: 'approved',
    first_name: 'Egia',
    last_name: 'Trading',
    confirmed_at: Date.current
)

client = IEX::Api::Client.new

stocks_symbols = ['AAPL', 'MSFT', 'CVX', 'BBBY', 'F', 'NVDA', 'NFLX', 'INTC', 'TSLA', 'T', 'KO', 'DIS', 'AMZN', 'WMT', 'JNJ','ABNB', 'ETSY', 'VZ', 'C', 'AMD']

stocks_symbols.each do |symbol|
    Stock.create(
        symbol: symbol,
        company_name: client.company(symbol).company_name,
        logo_url: client.logo(symbol).url
    )
end