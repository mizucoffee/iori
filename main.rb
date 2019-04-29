require 'bundler/setup'
Bundler.require
require 'sinatra'
require 'sinatra/json'
require 'sinatra/reloader' if development?
require './models/model.rb'

get '/' do
  erb :index
end

get '/@:id' do
  @user = params[:id]
  erb :userpage
end
