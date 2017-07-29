class Question < ActiveRecord::Base
  belongs_to :inquirer, class_name: :User
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :answers
  has_many :voters, through: :votes, source: :voter

  validates_presence_of :title, :body, :inquirer_id

  def sum_vote_values
    self.votes.map(&:value).reduce(:+)
  end
end
