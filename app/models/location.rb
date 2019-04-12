class Location < ApplicationRecord
  validates :address, presence: true
  validates :address, uniqueness: true
  validates :name, presence: true
  belongs_to :business
  has_many :location_playlists
  has_many :playlists, through: :location_playlists
  accepts_nested_attributes_for :playlists

  def self.by_state(state)
    where(state: state)
  end
  
end
