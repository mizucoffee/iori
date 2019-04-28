class CreateComposersSong < ActiveRecord::Migration
  def change
    create_table :composers_song do |t|
      t.integer :song_id
      t.integer :singers_id
    end
  end
end
