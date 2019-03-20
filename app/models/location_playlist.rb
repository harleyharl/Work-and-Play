class LocationPlaylist < ApplicationRecord
  belongs_to :location
  belongs_to :playlist
end
