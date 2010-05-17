require 'rubygems'
require 'sinatra'
 
set :environment,  :production
disable :run

require 'touchpage'

run Sinatra::Application