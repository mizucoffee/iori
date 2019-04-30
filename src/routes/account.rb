# /account Router
class Account < Base
  get '/login' do
    render :erb, :login
  end

  get '/login/auth/twitter' do
    redirect '/' unless session[:user_id].nil?

    token = Twi::OAuth.token('http://iori.mzcf.net/account/login/auth/twitter/callback')
    session['oauth_token_secret'] = token['oauth_token_secret']
    redirect "https://api.twitter.com/oauth/authenticate?oauth_token=#{token['oauth_token']}"
  end

  get '/login/auth/twitter/callback' do
    twitter = Twi::OAuth.callback(params['oauth_token'], session['oauth_token_secret'], params['oauth_verifier'])
    if twitter.key?('user_id')
      user = User.find_by(twitter_id: twitter['user_id'])
      if user.nil?
        user = User.create(
          display_name: twitter['display_name'],
          twitter_id: twitter['user_id']
        )
      end
      session['user_id'] = user.twitter_id
    end
    redirect '/'
  end
end
