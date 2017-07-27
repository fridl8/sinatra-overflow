5.times do
  User.create(username: Faker::Internet.user_name, password_hash: rand(1..9), email: Faker::Internet.email)
end

