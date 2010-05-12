class Item
  include DataMapper::Resource
  
  property :id, Serial
  property :uri, String
  property :width, Integer
  property :height, Integer
  
  # storing the created_at timestamp will help us track site participation
  # in order to have this set for us automatically, we've added:
  # require 'dm-timestamps'
  # to the list of required gems.
  property :created_at, DateTime
  
end