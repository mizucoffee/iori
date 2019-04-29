require 'sinatra'
require 'bundler/setup'
Bundler.require
require './main'

run Rack::URLMap.new(Iori::ROUTES)