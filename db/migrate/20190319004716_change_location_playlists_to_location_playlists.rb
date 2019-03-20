class ChangeLocationPlaylistsToLocationPlaylists < ActiveRecord::Migration[5.2]
  def change
    rename_table :LocationPlaylists, :location_playlists
  end
end
