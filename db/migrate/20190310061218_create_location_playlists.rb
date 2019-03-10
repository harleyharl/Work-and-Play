class CreateLocationPlaylists < ActiveRecord::Migration[5.2]
  def change
    create_table :LocationPlaylists do |t|
      t.integer :location_id
      t.integer :playlist_id
      t.time :string

      t.timestamps
    end
  end
end
