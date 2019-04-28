class CreateSingersSong < ActiveRecord::Migration
  def change
    create_table :singers_song do |t|
      t.integer :song_id
      t.integer :singers_id
    end
  end
end
