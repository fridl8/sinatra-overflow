class Question < ActiveRecord::Base
  belongs_to :inquirer, class_name: :User
  has_many :comments, as: :commentable
  has_many :votes, as: :votable
end
