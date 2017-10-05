Yt.configure do |config|
  config.api_key = ENV['GOOGLE_API_KEY']
  config.client_id = ENV['GOOGLE_CLIENT_ID']
  config.client_secret = ENV['GOOGLE_CLIENT_SECRET']
  config.log_level = :debug
end
