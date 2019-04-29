require './models/model.rb'
require './routes/base.rb'
require './routes/root.rb'
require './routes/api.rb'

# Iori
class Iori < Sinatra::Base
  ROUTES = {
    '/' => Root,
    '/api' => Api
  }.freeze
end
