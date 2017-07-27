get '/users/new' do
  erb :'/users/new'
end

post '/users' do
  if params[:password] == params[:confirm_password]
    new_user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if new_user.save
      redirect '/'
    else
      @errors = new_user.errors.full_messages
      erb :'/users/new'
    end
  else
    @errors = ["Passwords must match."]
    erb :'/users/new'
  end
end
