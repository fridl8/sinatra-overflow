get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  if !logged_in?
    if params[:user][:password] == params[:confirm_password]
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

get '/users/:id' do
  authorize!
  @user = User.find_by(id: params[:id])
  erb :"/users/show"
end
