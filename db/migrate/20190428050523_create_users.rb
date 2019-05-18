class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :screen_name
      t.string :name
      t.string :twitter_id
      t.boolean :show_like, default: true
      t.datetime :created_at,  null: false
      t.datetime :updated_at,  null: false
    end
  end
end
