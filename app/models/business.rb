class Business < ApplicationRecord
  validates :email_address, presence: true
  validates :email_address, uniqueness: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
  has_many :locations
  has_many :playlists
  #
  def to_param
    "#{id} #{name}".parameterize
  end
end
