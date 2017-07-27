get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  if !logged_in?
    if params[:password] == params[:confirm_password]
      new_user = User.new(params[:user])
      if new_user.save
        session[:user_id] = new_user.id
        redirect '/'
      else
        @errors = new_user.errors.full_messages
        erb :'/users/new'
      end
    else
      @errors = ["Passwords must match."]
      erb :'/users/new'
    end
  else
    @errors = ["You need to be logged out to do that."]
    erb :'/'
  end
end
