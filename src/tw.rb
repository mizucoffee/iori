# Twitter Api Wrapper
module Tw
  CONSUMER_KEY = ENV['CONSUMER_KEY']
  CONSUMER_SECRET = ENV['CONSUMER_SECRET']

  @app = Twitter::REST::Client.new do |config|
    config.consumer_key = CONSUMER_KEY
    config.consumer_secret = CONSUMER_SECRET
  end

  def self.app
    @app
  end

  def self.user(access_token,access_token_secret)
    Twitter::REST::Client.new do |config|
      config.consumer_key = CONSUMER_KEY
      config.consumer_secret = CONSUMER_SECRET
      config.access_token = access_token
      config.access_token_secret = access_token_secret
    end
  end
end
