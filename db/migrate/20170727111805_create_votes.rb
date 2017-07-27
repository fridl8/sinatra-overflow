class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :voter_id, null: false
      t.integer :votable_id, null: false
      t.string  :votable_type, null: false

      t.timestamps
    end
  end
end
