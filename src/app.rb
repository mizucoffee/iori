require './src/models'
require './src/base'
require './src/twitter_oauth'
require './src/tw'

require './src/routes/root'
require './src/routes/api'
require './src/routes/account'
require './src/routes/review'
require './src/routes/music'
require './src/routes/search'

# Iori
class Iori < Sinatra::Base
  ROUTES = {
    '/' => RootRouter,
    '/api' => ApiRouter,
    '/account' => AccountRouter,
    '/review' => ReviewRouter,
    '/music' => MusicRouter,
    '/search' => SearchRouter
  }.freeze
end
