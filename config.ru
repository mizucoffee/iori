require 'bundler/setup'
Bundler.require :default, (ENV['ENV'] || 'development').to_sym
Dotenv.load

require './src/app'

run Rack::URLMap.new(Iori::ROUTES)
