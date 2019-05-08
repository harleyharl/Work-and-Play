class RemoveTimeFromLocationPlaylists < ActiveRecord::Migration[5.2]
  def change
    remove_column :location_playlists, :time, :string
  end
end
