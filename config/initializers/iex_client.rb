IEX::Api.configure do |config|
    config.publishable_token = Rails.application.credentials.iex_publishable_test_token # defaults to ENV['IEX_API_PUBLISHABLE_TOKEN']
    config.secret_token = Rails.application.credentials.iex_secret_test_token # defaults to ENV['IEX_API_SECRET_TOKEN']
    config.endpoint = 'https://sandbox.iexapis.com/v1' # use 'https://sandbox.iexapis.com/v1' for Sandbox
  end