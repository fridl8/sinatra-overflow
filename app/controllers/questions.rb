get "/questions" do
  @questions = Question.all.order(:created_at)[0..9]
  erb :"questions/index"
end

get "/questions/:id" do
  @question = Question.find_by(id: params[:id])
  if request.xhr?
    @vote = @question.votes.find_by(voter_id: current_user.id)
    @vote.value.to_s
  end
  erb :"questions/show"
end


post "/questions" do
  if logged_in?
    new_question = Question.new(title: params[:title], inquirer_id: session[:user_id], body: params[:body])
    if request.xhr?
      if new_question.save
        @question = new_question
        content_type :json
        {question_id: @question.id}.to_json
      else
        status 422
      end
    else
      if new_question.save
        @question = new_question
        erb :"/questions/#{new_question.id}"
      else
        status 422
        @errors = new_question.errors.full_messages
        erb :'/questions/index'
      end
    end
  else
   redirect '/sessions/new'
  end
end
