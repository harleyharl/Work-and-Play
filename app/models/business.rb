class Business < ApplicationRecord
  validates :email_address, presence: true
  validates :email_address, uniqueness: true
  has_secure_password
  has_many :locations
  has_many :playlists


end
