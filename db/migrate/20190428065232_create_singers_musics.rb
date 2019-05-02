class CreateSingersMusics < ActiveRecord::Migration
  def change
    create_table :singers_musics do |t|
      t.integer :music_id
      t.integer :singers_id
    end
  end
end
