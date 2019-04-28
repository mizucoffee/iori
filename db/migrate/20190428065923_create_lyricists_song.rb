class CreateLyricistsSong < ActiveRecord::Migration
  def change
    create_table :lyricists_song do |t|
      t.integer :song_id
      t.integer :singers_id
    end
  end
end
