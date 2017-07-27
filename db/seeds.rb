COMMENT_AND_VOTE_TYPES = ["Question", "Answer", "Comment"]

User.delete_all
Comment.delete_all
Question.delete_all
Answer.delete_all
Vote.delete_all

50.times do
  User.create(username: Faker::Internet.user_name, password: 'password', email: Faker::Internet.email)
end

250.times do
  Comment.create(body: Faker::Hipster.paragraph, commenter_id: rand(1..50), commentable_id: rand(1..250), commentable_type: COMMENT_AND_VOTE_TYPES.sample )
end

250.times do
  Question.create(title: Faker::Lorem.sentence, body: Faker::Lorem.paragraph, favorite_answer_id: rand(1..250), inquirer_id: rand(1..50))
end

250.times do
  Answer.create(body: Faker::RickAndMorty.quote, responder_id: rand(1..50), question_id: rand(1..250))
end

500.times do
  Vote.create(voter_id: rand(1..50), votable_id: rand(1..250), votable_type: COMMENT_AND_VOTE_TYPES.sample)
end

