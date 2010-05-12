require 'rubygems' unless defined? ::RubyGems
require 'sinatra' unless defined? ::Sinatra
require 'rack'
require 'dm-core'
require 'dm-timestamps'
require 'haml'
require 'sass'
require 'ruby-debug'

configure :development do
  Sinatra::Application.reset!
  use Rack::Reloader
  
  DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/db/bottles.sqlite3")  
end

configure :production do
  require '/var/apps/respite/shared/config/production.rb'
end

require 'classes'

DataMapper.auto_upgrade!
#DataMapper.auto_migrate!

get '/' do
  haml :index
end

get '/style.css' do
  response['Content-Type'] = 'text/css; charset=utf-8'
  sass :style
end

helpers do  
  
end