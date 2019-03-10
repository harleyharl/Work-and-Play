class Business < ApplicationRecord
  has_secure_password

  has_many locations
  has_many playlists

end
