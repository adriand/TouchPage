require 'rubygems' unless defined? ::RubyGems
require 'sinatra' unless defined? ::Sinatra
require 'rack'
require 'dm-core'
require 'dm-timestamps'
require 'haml'
require 'sass'
require 'dm-paperclip'

configure :development do
  require 'ruby-debug'
  Sinatra::Application.reset!
  use Rack::Reloader
end

DataMapper.setup(:default, "sqlite3://touchpage.sqlite3")  

require 'classes'

DataMapper.auto_upgrade!
#DataMapper.auto_migrate!

get '/' do
  @items = Item.all
  @js = erb :index_js
  haml :index
end

get '/new' do
  haml :new
end

post '/create' do
  @item = Item.new(params[:item])
  @item.image = make_paperclip_mash(params[:image])
  if @item.save
    redirect '/new'
  else
    haml :new
  end
end

get '/manage' do
  @items = Item.all
  haml :manage
end

# TODO: shouldn't be a get
get '/destroy/:id' do
  @item = Item.get(params[:id])
  @item.destroy
  redirect '/manage'
end

get '/style.css' do
  response['Content-Type'] = 'text/css; charset=utf-8'
  sass :style
end

helpers do  
  
end

# http://blog.wyeworks.com/2010/2/10/making-paperclip-work-with-sinatra-datamapper
def make_paperclip_mash(file_hash)
  mash = Mash.new
  mash['tempfile'] = file_hash[:tempfile]
  mash['filename'] = file_hash[:filename]
  mash['content_type'] = file_hash[:type]
  mash['size'] = file_hash[:tempfile].size
  mash
end