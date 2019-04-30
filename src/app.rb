require './src/models'
require './src/base'
require './src/twitter_oauth'
require './src/tw'
require './src/routes/root'
require './src/routes/api'
require './src/routes/account'

# Iori
class Iori < Sinatra::Base
  ROUTES = {
    '/' => Root,
    '/api' => Api,
    '/account' => Account
  }.freeze
end
