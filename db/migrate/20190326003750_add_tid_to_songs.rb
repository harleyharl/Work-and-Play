class AddTidToSongs < ActiveRecord::Migration[5.2]
  def change
    add_column :songs, :tid, :string
  end
end
