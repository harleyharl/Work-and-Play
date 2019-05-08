class RemoveStringFromLocationPlaylists < ActiveRecord::Migration[5.2]
  def change
    remove_column :location_playlists, :string, :time
  end
end
