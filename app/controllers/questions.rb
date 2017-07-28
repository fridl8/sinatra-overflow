get "/questions" do
  @questions = Question.all.order(:created_at)[0..9]
  p @questions
  erb :"questions/index"
end

get "/questions/:id" do
  @question = Question.find_by(id: params[:id])
  erb :"questions/show"
end

post "/questions" do
  if logged_in?
    if request.xhr?
      new_question = Question.new(title: params[:title], inquirer_id: session[:user_id], body: params[:body])
      if new_question.save
        @question = new_question
        content_type :json
        {question_id: @question.id}.to_json
      else
        @errors = new_question.errors.full_messages
        erb :'/questions/index'
      end
    else
      error 422
    end
  else
    error 422
  end
end
