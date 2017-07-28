post '/comments' do
  if logged_in?
    if params[:comment_type] == "question"
      current_question = Question.find_by(id: params[:current_question_id].to_i)
      if request.xhr?
        if current_question.comments << Comment.new(body: params[:body], commenter_id: session[:user_id]) == false
          status 422
        else
          erb :'/comments/_show', layout: false, :locals => {votes: current_question.votes.count, body: current_question.comments.last.body, username: current_user.username, created_at: current_question.comments.last.created_at}
        end
      else
        if current_question.comments << Comment.new(body: params[:body], commenter_id: session[:user_id]) == false
          status 422
          @errors = ["Something went wr0ng :'("]
          erb :"/questions/#{current_question.id}"
        else
          redirect "/questions/#{current_question.id}"
        end
      end
    else
      current_answer = Answer.find_by(id: params[:current_answer_id].to_i)
      if request.xhr?
        if current_answer.comments << Comment.new(body: params[:body], commenter_id: session[:user_id]) == false
          status 422
        else
          erb :'/comments/_show', layout: false, :locals => {votes: current_answer.votes.count, body: current_answer.comments.last.body, username: current_user.username, created_at: current_answer.comments.last.created_at}
        end
      else
        if current_answer.comments << Comment.new(body: params[:body], commenter_id: session[:user_id]) == false
          status 422
          @errors = ["Something went wr0ng :'("]
          erb :"/questions/#{current_answer.question.id}"
        else
          redirect "/questions/#{current_answer.question.id}"
        end
      end
    end
  else
    @errors = ["You nEed to be logged in!"]
    erb :'/sessions/login'
  end
end
