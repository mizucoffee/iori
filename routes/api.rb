require './routes/base.rb'

# /api Router
class Api < Base
  get '/' do
    'Iori!'
  end
end
