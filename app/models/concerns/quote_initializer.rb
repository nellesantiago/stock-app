module QuoteInitializer
    def get_quote
        @client = IEX::Api::Client.new
        @client.quote(symbol)
    end
end