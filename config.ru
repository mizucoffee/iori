require 'bundler/setup'
Bundler.require :default, (ENV['ENV'] || 'development').to_sym
Dotenv.load

require './main'

run Rack::URLMap.new(Iori::ROUTES)
