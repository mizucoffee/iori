# Route Base
class Base < Sinatra::Base
  set :root, File.expand_path('../', File.dirname(__FILE__))
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  before do
    @me = User.find_by(twitter_id: session['user_id'])
    unless @me.nil?
      @twitter = Tw.user(session['access_token'], session['access_token_secret']).user(session['user_id'].to_i)
    end
  end
end
