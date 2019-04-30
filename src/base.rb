# Route Base
class Base < Sinatra::Base
  set :root, File.expand_path('../', File.dirname(__FILE__))
  enable :sessions

  configure :development do
    register Sinatra::Reloader
  end

  before do
  end
end
