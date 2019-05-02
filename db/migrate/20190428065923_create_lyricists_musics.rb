class CreateLyricistsMusics < ActiveRecord::Migration
  def change
    create_table :lyricists_musics do |t|
      t.integer :music_id
      t.integer :artist_id
    end
  end
end
