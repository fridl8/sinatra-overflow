post "/questions/:id/votes" do
  # if user already has voted on this question
  # modify the value of their vote
  # otherwise create a new vote for this question
  # by this user and give it a value according
  # to what button they pressed
  
  if !logged_in?
    status 401
  else
    @question = Question.find_by(id: params[:id])
    if request.xhr?
      if !@question.votes.find_by(voter_id: current_user.id)
        if params[:vote] == '1'
          p "P" * 20
          @question.votes << Vote.new(voter_id: current_user.id, value: 1)
          p @question.sum_vote_values.to_s
        elsif params[:vote] == '-1'
          p "Z" * 20
          @question.votes << Vote.new(voter_id: current_user.id, value: -1)
          p @question.sum_vote_values.to_s
        end
      else
        @vote = @question.votes.find_by(voter_id: current_user.id)
        if params[:vote] == '1'
          p "X" * 20
          p @vote
          @vote.value = 1
          p @vote
          p @question.sum_vote_values.to_s
        elsif params[:vote] == '-1'
          p "Q" * 20
          p @vote
          @vote.value = -1
          p @vote
          p @question.sum_vote_values.to_s
        else
          p "Y" * 20
          p @vote
          @vote.delete
          p @question.sum_vote_values.to_s
        end
      end
    end
  end
end
