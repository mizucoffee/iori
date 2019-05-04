require './src/models'
require './src/base'
require './src/twitter_oauth'
require './src/tw'

require './src/routes/root'
require './src/routes/api'
require './src/routes/account'
require './src/routes/review'
require './src/routes/music'

# Iori
class Iori < Sinatra::Base
  ROUTES = {
    '/' => RootRouter,
    '/api' => ApiRouter,
    '/account' => AccountRouter,
    '/review' => ReviewRouter,
    '/music' => MusicRouter
  }.freeze
end
