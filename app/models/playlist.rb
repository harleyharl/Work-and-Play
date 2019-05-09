class Playlist < ApplicationRecord
  belongs_to :business
  has_many :location_playlists
  has_many :locations, through: :location_playlists
  has_many :songs
end
