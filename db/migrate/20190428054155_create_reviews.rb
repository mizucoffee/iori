class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.integer :music_id
      t.integer :user_id
      t.string :body
      t.integer :hue
      t.boolean :light, default: true
      t.integer :review_type
      t.datetime :created_at,  null: false
      t.datetime :updated_at,  null: false
    end
  end
end
