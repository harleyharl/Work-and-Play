class Location < ApplicationRecord
  validates :address, presence: true
  validates :address, uniqueness: true
  belongs_to :business
  has_many :location_playlists
  has_many :playlists, through: :location_playlists

end
