class CreateSingersMusics < ActiveRecord::Migration
  def change
    create_table :singers_musics do |t|
      t.integer :music_id
      t.integer :artist_id
    end
  end
end
