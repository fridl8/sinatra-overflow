get "/questions" do
  @questions = Question.all.order(:created_at)[0..9]
  erb :"questions/index"
end

get "/questions/:id" do
  @question = Question.find_by(id: params[:id])
  erb :"questions/show"
end
