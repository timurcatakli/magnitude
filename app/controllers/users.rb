get '/users/new' do
  if session[:user_id]
    @user = User.find(session[:user_id])
    redirect "/users/#{@user.id}"
  else
    erb :register
  end
end

post '/users/new' do

# {"phone"=>"(650) 322-4534", "mag"=>"6",
#{ }"address"=>"D524, 63700 La Crouzille, France", "radius"=>"4123", "lat"=>"46.15242437752303", "lon"=>"2.7470703125"}

  @user = User.new
  @user.first_name = "John"
  @user.last_name = "Doe"
  @user.email = "jdoe@jdoe.com"
  @user.phone = params[:user][:phone]
  @user.password = "password"
  @user.save
  session[:user_id] = @user.id

  @request = Request.new
  @request.location = params[:user][:address]
  @request.radius = params[:user][:radius]
  @request.latitude = params[:user][:lat]
  @request.longtitude = params[:user][:lon]
  @request.magnitude = params[:user][:mag]
  @request.user_id = @user.id
  @request.save
  
  puts '*' * 100
  puts @user.save
  puts '*' * 100
end

post '/users/verification' do

  @verification_user = User.find(session[:user_id])
      puts '=' * 100
      puts session[:user_id]
      puts params[:sms_verification]
      puts '=' * 100



  if request.xhr?
    if @verification_user.sms_verification == params[:sms_verification]
    @verification_user.active = true
    @verification_user.save  
    content_type :json
    { match: true }.to_json
    else
    content_type :json
    { match: false }.to_json
    end
    

  else
    redirect "/posts/#{@post.id}"
  end

end

get '/users/:user_id' do
  @logged_in_as = User.find(session[:user_id]) if session[:user_id]
  @viewing_user = User.find(params[:user_id])

  if @logged_in_as && @logged_in_as.id == @viewing_user.id
    erb :user
  else
    erb :not_authorized
  end
end
