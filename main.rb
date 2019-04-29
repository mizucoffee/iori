require './src/models'
require './src/base'
require './src/twitter'
require './src/routes/root'
require './src/routes/api'

# Iori
class Iori < Sinatra::Base
  ROUTES = {
    '/' => Root,
    '/api' => Api
  }.freeze
end
