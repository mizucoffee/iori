class CreateArrangersMusics < ActiveRecord::Migration
  def change
    create_table :arrangers_musics do |t|
      t.integer :music_id
      t.integer :arrangers_id
    end
  end
end
