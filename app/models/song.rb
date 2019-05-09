class Song < ApplicationRecord
  belongs_to :playlist

  scope :more_songs_by_artist, -> (artist){ where('artist = ?', artist)}

end
