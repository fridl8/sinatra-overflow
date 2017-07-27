class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string    :title, null: false
      t.string    :body, null: false
      t.integer   :favorite_answer_id
      t.integer   :inquirer_id, null: false

      t.timestamps
    end
  end
end
