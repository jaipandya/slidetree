require 'sinatra/reloader' if development?
require "sinatra/jsonp"
require 'simple-rss'
require 'open-uri'
require 'json'

# I exist!
get '/' do
  erb :index
end

# Fetches popular rss from SlideShare and converts into json object
get '/get_popular' do
  SimpleRSS.item_tags << :"slideshare:views"
  SimpleRSS.item_tags << :"slideshare:comments"
  SimpleRSS.item_tags << :"slideshare:thumbnail"
  rss = SimpleRSS.parse open('http://www.slideshare.net/rss/popular')
  response = rss.items.collect do |item|
    {
      :name => item.title,
      :link => item.link,
      :description => item.description,
      :author => item.author,
      :size => item.slideshare_views,
      :comments => item.slideshare_comments,
      :thumbnail_url => item.slideshare_thumbnail
    }
  end
  response = {
   :name => "popular-presentations",
   :children => response
  }
  content_type :json
  jsonp response
end