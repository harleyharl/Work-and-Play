class DropSpotifyUsersTable < ActiveRecord::Migration[5.2]
  def change
    drop_table :spotify_users do |t|
      t.string "name"
      t.string "email_address"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
