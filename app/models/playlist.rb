class Playlist < ApplicationRecord
  belongs_to :business
  has_many :location_playlists
  has_many :locations, through: :location_playlists
  has_many :songs

  # def playlist_1=(playlist_1)
  #   self.playlist_1 = Playlist.find_by(name: name)
  # end
  #
  # def playlist_1
  #   binding.pry
  #   self.playlist_1 ? self.playlist.name : nil
  # end

end
