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
end
