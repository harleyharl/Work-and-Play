class AddTimeSlotToPlaylists < ActiveRecord::Migration[5.2]
  def change
    add_column :playlists, :time_slot, :integer
  end
end
