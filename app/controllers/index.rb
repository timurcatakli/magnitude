require 'rubygems'
require 'twilio-ruby'

get '/pull' do


# Make Earthquake API request to USGS
url = 'http://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_hour.geojson'
uri = URI(url)
response = Net::HTTP.get(uri)
parsed_response = JSON.parse(response)
@earthquakes = parsed_response["features"]
# Make Earthquake API request to USGS

# Insert Earthquake feed into database
@earthquakes.each do |e|
  new_earthquake = Feed.new
  new_earthquake.feedid = e['id']
  new_earthquake.mag = e['properties']['mag']
  new_earthquake.place = e['properties']['place']
  new_earthquake.time = Time.at(e['properties']['time'] / 1000)
  new_earthquake.alert = e['properties']['alert']
  new_earthquake.latitude = e['geometry']['coordinates'][1]
  new_earthquake.longtitude = e['geometry']['coordinates'][0]
  new_earthquake.save
end
# Insert Earthquake feed into database

  @earthquakes_stored = Feed.all.order(created_at: :desc)
  
  erb :'/earthquakes/pull', :layout => :layout_pull
end

get '/secret' do
  redirect '/sessions/new' unless session[:user_id]
  "Secret area!"
end

get '/sms' do
  erb :'/earthquakes/sms'  
end

get '/' do
  erb :'/index'
end

post '/' do 

#   @restaurant = Restaurant.find(params[:restaurant_id])

#   @review = @restaurant.reviews.new(params[:review])
#   @review.restaurant_id = @restaurant.id
#   @review.user_id = current_user.id

puts '=' * 100
puts params[:feed]
puts '=' * 100

#   if @review.save
#     redirect "/restaurants/#{@restaurant.id}/thank_you"
#   else
#     erb :'reviews/new'
#   end
  erb :'/show'
end







