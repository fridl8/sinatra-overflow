COMMENT_AND_VOTE_TYPES = ["Question", "Answer", "Comment"]

User.delete_all
Comment.delete_all
Question.delete_all
Answer.delete_all
Vote.delete_all

user_amount = 50
comment_amount = 1000
question_amount = 250
vote_amount = 5000
answer_amount = 333

user_amount.times do
  User.create!(username: Faker::Internet.user_name, password: 'password', email: Faker::Internet.email)
end

comment_amount.times do
  Comment.create!(body: Faker::Hipster.paragraph, commenter_id: rand(1..user_amount), commentable_id: rand(1..comment_amount), commentable_type: COMMENT_AND_VOTE_TYPES.sample )
end

question_amount.times do
  Question.create!(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, favorite_answer_id: rand(1..answer_amount), inquirer_id: rand(1..user_amount))
end


vote_amount.times do #not sure if I broke the voting portion - Matt
  Vote.create!(voter_id: rand(1..user_amount), votable_id: rand(1..question_amount), votable_type: COMMENT_AND_VOTE_TYPES.sample, value: [-1,1].sample)
end

answer_amount.times do
  Answer.create!(body: Faker::RickAndMorty.quote, responder_id: rand(1..user_amount), question_id: rand(1..question_amount))
end
