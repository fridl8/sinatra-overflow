class Comment < ActiveRecord::Base
  belongs_to :commenter, class_name: :User
  belongs_to :commentable, polymorphic: true
  has_many :votes, as: :votable, dependent: :destroy

  validates_presence_of :body, :commenter_id, :commentable_id, :commentable_type
end
