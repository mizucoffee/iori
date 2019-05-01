class CreateComposersMusic < ActiveRecord::Migration
  def change
    create_table :composers_music do |t|
      t.integer :music_id
      t.integer :singers_id
    end
  end
end
