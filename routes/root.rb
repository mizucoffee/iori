# / Router
class Root < Base
  get '/' do
    erb :index
  end

  get '/@:id' do
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['CONSUMER_KEY']
      config.consumer_secret     = ENV['CONSUMER_SECRET']
    end

    @user = client.user(params[:id])

    erb :userpage
  end
end
