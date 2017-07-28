post '/comments' do
  if logged_in?
    if lsdflj == 'question'
    if request.xhr?
      if new_comment.save

      else
        status 422
      end
    else
      if new_comment.save
      else
        status 422
        @errors = new_comment.errors.full_messages
        erb :"/questions/#{q_id}"
      end
    end
  else
    @errors = ["You need to be logged in"]
    erb :'/sessions/login'
  end
end
