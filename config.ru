require 'rubygems'
require 'bundler'

Bundler.require(:default, ENV['RACK_ENV'].to_sym)

enable :logging
set :port, 80

require './app'

run Sinatra::Application