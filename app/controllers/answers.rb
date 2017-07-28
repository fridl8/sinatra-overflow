get "/answers/test" do
  erb :"answers/_new"
end


post "/questions/:id/answers" do
  @answer = Answer.new(body: params[:body], responder_id: current_user.id, question_id: params[:id])
  if @answer.save
    if request.xhr?
      puts "AJAX REQUEST SUCCESSFUL"
      erb :"answers/_answer", layout: false
    else
      @question = Question.find_by(id: params[:id])
      erb :"questions/show"
    end
  else
    @question = Question.find_by(id: params[:id])
    @errors = @answer.errors.full_messages
    erb :"questions/show"
  end
end
