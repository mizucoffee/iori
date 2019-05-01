class CreateSingersMusic < ActiveRecord::Migration
  def change
    create_table :singers_music do |t|
      t.integer :music_id
      t.integer :singers_id
    end
  end
end
