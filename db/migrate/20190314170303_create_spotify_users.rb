class CreateSpotifyUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :spotify_users do |t|
      t.string :name
      t.string :email_address

      t.timestamps
    end
  end
end
