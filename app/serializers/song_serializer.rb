class SongSerializer < ActiveModel::Serializer
  attributes :id, :name, :artist, :track_id
end
