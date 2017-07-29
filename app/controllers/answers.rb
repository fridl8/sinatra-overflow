get "/answers/test" do
  erb :"answers/_new"
end


post "/questions/:id/answers" do
  if logged_in?
    @answer = Answer.new(body: params[:body], responder_id: current_user.id, question_id: params[:id])
    if request.xhr?
      if @answer.save
        puts "AJAX REQUEST SUCCESSFUL"
        erb :"/answers/_answer", layout: false
      else
        status 422
      end
    else
      @question = Question.find_by(id: params[:id])
      @errors = @answer.errors.full_messages
      erb :"questions/show"
    end
  else
    @errors = ["You must be logged in"]
    erb :'/sessions/login'
  end
end
