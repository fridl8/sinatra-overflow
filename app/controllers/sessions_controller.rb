get '/sessions/new' do
	erb :'/sessions/login'
end

post '/sessions' do
	user = User.find_by(email: params[:user][:email])
	if user && user.authenticate(params[:user][:password], params[:user][:email])
		session[:user_id] = user.id
		redirect '/'
	else
		@errors = ["Could not log in"]
		erb :'/sessions/login'
	end
end

delete '/sessions' do
	session.delete(:user_id)
	redirect '/'
end