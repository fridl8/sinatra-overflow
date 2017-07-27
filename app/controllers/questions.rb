get "/questions/:id" do
  @question = Question.find_by(id: params[:id])
  erb :"questions/show"
end
