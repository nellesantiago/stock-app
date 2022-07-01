# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

client = IEX::Api::Client.new

stocks_symbols = ['AMZN', 'AAPL', 'NVDA', 'MSFT', 'NFLX', 'KO', 'INTC', 'SNOW', 'DIS', 'CVX', 'T', 'SHOP', 'ABNB', 'ETSY', 'VZ', 'JNJ', 'C', 'F', 'WMT']

stocks_symbols.each do |symbol|
    Stock.create(
        symbol: symbol,
        company_name: client.company(symbol).company_name,
        logo_url: client.logo(symbol).url
    )
end