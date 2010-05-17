class Item
  include DataMapper::Resource
  include Paperclip::Resource
  
  property :id, Serial
  property :title, String
  property :uri, String
  
  property :image_file_name, String
  property :image_content_type, String
  property :image_file_size, Integer
  property :image_updated_at, DateTime
  
  property :created_at, DateTime
  
  has_attached_file :image, 
                    :styles => { :thumb => "200x300>" },
                    :url => "/system/:attachment/:id/:style/:basename.:extension",
                    :path => "#{Dir.pwd}/public/system/:attachment/:id/:style/:basename.:extension" 
end