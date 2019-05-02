class CreateComposersMusics < ActiveRecord::Migration
  def change
    create_table :composers_musics do |t|
      t.integer :music_id
      t.integer :composers_id
    end
  end
end
