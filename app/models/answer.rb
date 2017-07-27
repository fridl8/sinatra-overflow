class Answer < ActiveRecord::Base
  belongs_to :responder, class_name: :User
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
end