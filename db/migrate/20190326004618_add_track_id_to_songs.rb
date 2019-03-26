class AddTrackIdToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :track_id, :string
  end
end
