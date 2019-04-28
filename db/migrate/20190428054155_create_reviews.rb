class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :song_id
      t.integer :user_id
      t.string :body
      t.string :color
      t.integer :type
      t.datetime :created_at,  null: false
      t.datetime :updated_at,  null: false
    end
  end
end
