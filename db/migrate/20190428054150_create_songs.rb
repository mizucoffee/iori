class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
      t.string :name
      t.integer :singer
      t.integer :composer
      t.integer :lyricist
      t.integer :genre
    end
  end
end
