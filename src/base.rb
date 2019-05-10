# Route Base
class Base < Sinatra::Base
  set :root, File.expand_path('../', File.dirname(__FILE__))
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  before do
    path = "#{request.env['SCRIPT_NAME']}#{request.env['PATH_INFO']}"
    query = request.env['QUERY_STRING']
    if %r{\/$}.match?(path) && path != '/'
      p = path.gsub(%r{\/$}, '')
      p = "#{p}?#{query}" unless query.empty?
      redirect(p, 301)
    end

    @me = User.find_by(twitter_id: session['user_id'])
    unless @me.nil?
      @twitter = Tw.user(session['access_token'], session['access_token_secret']).user(session['user_id'].to_i)
    end
  end

  not_found do
    erb :'routes/notfound'
  end
end
