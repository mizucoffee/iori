# /account Router
class AccountRouter < Base
  get '/login' do
    redirect '/' unless @me.nil?
    @next = params[:next]
    render :erb, :login
  end

  get '/login/auth/twitter' do
    redirect '/' unless @me.nil?
    token = Twi::OAuth.token("http://iori.mzcf.net/account/login/auth/twitter/callback?next=#{params[:next]}")
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
      session['oauth_token_secret'] = nil
      session['user_id'] = user.twitter_id
      session['access_token'] = twitter['oauth_token']
      session['access_token_secret'] = twitter['oauth_token_secret']
    end
    redirect params[:next] || '/'
  end

  get '/settings' do
    redirect '/account/login?next=/account/settings' if @me.nil?
    render :erb, :index
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
