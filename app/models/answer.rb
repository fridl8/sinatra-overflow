class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :responder, class_name: :User
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy

  validates_presence_of :body, :responder_id, :question_id

  def sum_vote_values
    self.votes.sum(:value)
  end
end
