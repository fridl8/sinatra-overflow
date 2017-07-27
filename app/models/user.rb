class User < ActiveRecord::Base

  has_many :votes, foreign_key: :voter_id
  has_many :questions, foreign_key: :inquirer_id
  has_many :comments, foreign_key: :commenter_id
  has_many :answers, foreign_key: :responder_id

  validates_presence_of :username, :email, :password
  validates_uniqueness_of :email, :username
  validates_format_of :email, with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates_length_of :password, {in: 6..25}

  def password
    @password
  end

  def password=(new_password)
    @password = new_password
    self.password_hash = BCrypt::Password.create(new_password)
  end

  def authenticate(plain_text_password, email_input)
    user_logging_in = User.find_by(email: email_input)
    BCrypt::Password.new(user_logging_in.password_hash) == plain_text_password && self.email == email_input
  end

end
