class AddBusinessIdToPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :business_id, :integer
  end
end
