class CreateLikes < ActiveRecord::Migration
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer :review_id
      t.datetime :created_at,  null: false
      t.datetime :updated_at,  null: false
    end
  end
end
