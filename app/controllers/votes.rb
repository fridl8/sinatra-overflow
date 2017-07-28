post "/questions/:id/votes" do
  authorize!
  @question = Question.find_by(id: params[:id])
  if request.xhr?
    # Vote.create(voter_id: current_user.id)
    if params[:vote] > 0
      @question << Vote.new(voter_id: current_user.id, value: 1)
      @question.sum_vote_values
    elsif params[:vote] < 0
      @question << Vote.new(voter_id: current_user.id, value: -1)
      @question.sum_vote_values
    end
  end
end
