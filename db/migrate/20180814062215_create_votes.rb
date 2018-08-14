class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :score
      t.integer :user_id
      t.integer :review_id
      t.integer :restaurant_id

      t.timestamps null: false
    end
  end
end
