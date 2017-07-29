helpers do
  def vote
    if !@question.votes.find_by(voter_id: current_user.id)
      if params[:vote] == '1'
        @question.votes << Vote.new(voter_id: current_user.id, value: 1)
        p @question.sum_vote_values.to_s
      elsif params[:vote] == '-1'
        @question.votes << Vote.new(voter_id: current_user.id, value: -1)
        p @question.sum_vote_values.to_s
      end
    else
      @vote = @question.votes.find_by(voter_id: current_user.id)
      if params[:vote] == '1'
        p "X" * 20
        @vote.value = 1
        p @question.sum_vote_values.to_s
      elsif params[:vote] == '-1'
        p "Q" * 20
        @vote.value = -1
        p @question.sum_vote_values.to_s
      else
        p "Y" * 20
        @vote.delete
        p @question.sum_vote_values.to_s
      end
    end
  end

  def on_upvote
    @vote = @question.votes.find_by(voter_id: current_user.id)
    if @vote
      @vote.value == 1 ? " on" : ""
    end
  end

  def on_downvote
    @vote = @question.votes.find_by(voter_id: current_user.id)
    if @vote
      @vote.value == -1 ? " on" : ""
    end
  end
end
