class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name, :address, :state
  has_many :playlists
end
