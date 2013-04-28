  class Tweetdb
  include Tire::Model::Persistence
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessor :created_at,:id,:text,:tag,:source,:user_id,:user_name,:screen_name,:location
  validates_presence_of :text, :id
  
  property :id, :type => 'long'
  property :text, :type => 'string',:analyzer => 'keyword'
  property :tag, :default => [], :analyzer => 'keyword'
  property :created_at,:type=>'time'  
  property :source, :type=>'string'
  property :user_id, :type=>'long'
  property :user_name,:type=>'string'
  property :screen_name, :type=>'string'
  property :location, :type=>'string'
  index_name 'tweets'
end