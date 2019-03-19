class Location < ApplicationRecord
  validates :address, presence: true
  validates :address, uniqueness: true
  validates :name, presence: true
  belongs_to :business
  has_many :location_playlists
  has_many :playlists, through: :location_playlists
  accepts_nested_attributes_for :playlists

  # def playlist_1=(name)
  #   binding.pry
  #   self.playlist_1 = Playlist.find_by(name: name)
  # end
  #
  # def playlist_1
  #   binding.pry
  #   self.playlist_1 ? self.playlist_1 : nil
  # end

  # def playlist_ids=(ids)
  #   binding.pry
  #   ids.each do |id|
  #     playlist = Playlist.find(id)
  #     self.playlists << playlist
  #   end
  # end
  #
  # def playlist_ids
  #   binding.pry
  # end

end
