post "/questions/:id/votes" do
  authorize!
  @question = Question.find_by(id: params[:id])
  if request.xhr?
    if params[:vote] == '1'
      @question.votes << Vote.new(voter_id: current_user.id, value: 1)
      @question.sum_vote_values.to_s
    elsif params[:vote] == '-1'
      @question.votes << Vote.new(voter_id: current_user.id, value: -1)
      @question.sum_vote_values.to_s
    else
      @question.votes.find_by(voter_id: current_user.id).delete
      @question.sum_vote_values.to_s
    end
  end
end
