# /account Router
class AccountRouter < Base
  get '/login' do
    redirect '/' unless @me.nil?
    @next = params[:next]
    erb :'routes/account/login'
  end

  get '/login/auth/twitter' do
    redirect '/' unless @me.nil?
    token = Twi::OAuth.token("http://#{ENV['DOMAIN']}/account/login/auth/twitter/callback?next=#{params[:next]}")
    session['oauth_token_secret'] = token['oauth_token_secret']
    redirect "https://api.twitter.com/oauth/authenticate?oauth_token=#{token['oauth_token']}"
  end

  get '/login/auth/twitter/callback' do
    tw = Twi::OAuth.callback(params['oauth_token'], session['oauth_token_secret'], params['oauth_verifier'])
    if tw.key?('user_id')
      twitter = Tw.user(tw['oauth_token'], tw['oauth_token_secret']).user(tw['user_id'].to_i)

      user = User.find_by(twitter_id: twitter.id)
      if user.nil?
        user = User.create(
          screen_name: twitter.screen_name,
          name: twitter.name,
          twitter_id: twitter.id
        )
      else
        user.name = twitter.name
        user.screen_name = twitter.screen_name
        user.save
      end
      session['oauth_token_secret'] = nil
      session['user_id'] = user.twitter_id
      session['access_token'] = tw['oauth_token']
      session['access_token_secret'] = tw['oauth_token_secret']
    end
    redirect params[:next] || '/'
  end

  get '/settings' do
    redirect '/account/login?next=/account/settings' if @me.nil?
    @success = params['success'] == 'true'
    render :erb, :'routes/account/settings'
  end

  post '/settings' do
    redirect '/account/login?next=/account/settings' if @me.nil?
    @me.show_like = params['show-like'] == 'on'
    @me.save

    redirect '/account/settings?success=true'
  end

  get '/delete' do
    @me.destroy
    session.clear

    redirect '/'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end
end
