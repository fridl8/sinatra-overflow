get "/answers/test" do
  erb :"answers/_new"
end


post "/questions/:id/answers" do
  @answer = Answer.new(body: params[:body], responder_id: current_user.id, question_id: params[:id])
  if @answer.save
    @question = Question.find_by(id: params[:id])
    erb :"questions/show"
    # if request.xhr?
    #   puts "AJAX REQUEST SUCCESSFUL"
    # end
  else
    redirect "/questions/:id"
  end
end
