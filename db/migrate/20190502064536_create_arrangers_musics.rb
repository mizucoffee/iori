class CreateArrangersMusics < ActiveRecord::Migration
  def change
    create_table :arrangers_musics do |t|
      t.integer :music_id
      t.integer :artist_id
    end
  end
end
