class AddEnergyToLocationPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :location_playlists, :energy, :string
  end
end
