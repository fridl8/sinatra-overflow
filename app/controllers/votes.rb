post "/questions/:id/votes" do
  if !logged_in?
    status 401
  else
    @question = Question.find_by(id: params[:id])
    if request.xhr?
      # if a vote does not exist on this question for this user
      if !@question.votes.find_by(voter_id: current_user.id)
        if params[:vote] == '1'
          @question.votes << Vote.new(voter_id: current_user.id, value: 1)
          @question.sum_vote_values.to_s
        elsif params[:vote] == '-1'
          @question.votes << Vote.new(voter_id: current_user.id, value: -1)
          @question.sum_vote_values.to_s
        end
      else
        @vote = @question.votes.find_by(voter_id: current_user.id)
        if params[:vote] == '1'
          @vote.value = 1
          @vote.save
          @question.sum_vote_values.to_s
        elsif params[:vote] == '-1'
          @vote.value = -1
          @vote.save
          @question.sum_vote_values.to_s
        else
          @vote.delete
          @question.sum_vote_values.to_s
        end
      end
    end
  end
end

post "/answers/:id/votes" do
  if !logged_in?
    status 401
  else
    @answer = Answer.find_by(id: params[:id])
    if request.xhr?
      # if a vote does not exist on this question for this user
      if !@answer.votes.find_by(voter_id: current_user.id)
        if params[:vote] == '1'
          @answer.votes << Vote.new(voter_id: current_user.id, value: 1)
          @answer.sum_vote_values.to_s
        elsif params[:vote] == '-1'
          @answer.votes << Vote.new(voter_id: current_user.id, value: -1)
          @answer.sum_vote_values.to_s
        end
      else
        @vote = @answer.votes.find_by(voter_id: current_user.id)
        if params[:vote] == '1'
          @vote.value = 1
          @vote.save
          @answer.sum_vote_values.to_s
        elsif params[:vote] == '-1'
          @vote.value = -1
          @vote.save
          @answer.sum_vote_values.to_s
        else
          @vote.delete
          @answer.sum_vote_values.to_s
        end
      end
    end
  end
end
