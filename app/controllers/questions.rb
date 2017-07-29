get "/questions" do
  @questions = Question.all.order('created_at DESC').limit(10)
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
    @errors = ["You need to be logged in"]
    erb :'/sessions/login'
  end
end

post '/questions/:id/favorite' do
  if logged_in?
    @question = Question.find_by(id: params[:id])
    if current_user.id == @question.inquirer_id
      if request.xhr?
        @question.favorite_answer_id = params[:answer_id]
        if @question.save
          "Favorited"
        else
          status 422
        end
      else
        @question.favorite_answer_id = params[:answer_id]
        if @question.save
          redirect back
        else
          @errors = ["Couldn't do that"]
          erb :"/questions/#{params[:id]}"
        end
      end
    else
      status 422
    end
  else
    @errors = ["You must be logged iN"]
    erb :'/sessions/login'
  end
end
