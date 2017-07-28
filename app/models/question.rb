class Question < ActiveRecord::Base
  belongs_to :inquirer, class_name: :User
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  has_many :answers

  validates_presence_of :title, :body, :inquirer_id
end
