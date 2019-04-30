# /account Router
class Account < Base
  get '/login' do
    render :erb, :login
  end

  get '/login/auth/twitter' do
    token = Twi::OAuth.token('http://iori.mzcf.net/account/login/auth/twitter/callback')
    session['oauth_token_secret'] = token['oauth_token_secret']
    redirect "https://api.twitter.com/oauth/authenticate?oauth_token=#{token['oauth_token']}"
  end

  get '/login/auth/twitter/callback' do
    Twi::OAuth.callback(params['oauth_token'], session['oauth_token_secret'], params['oauth_verifier']).to_s
  end
end
