class PlaylistSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :songs

  # belongs_to :business
  # has_many :location_playlists
  # has_many :locations, through: :location_playlists
end
