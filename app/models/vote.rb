class Vote < ActiveRecord::Base
  belongs_to :voter, class_name: :User
  belongs_to :votable, polymorphic: true

  validates_presence_of :voter_id, :votable_id, :votable_type


end
