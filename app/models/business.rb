class Business < ApplicationRecord
  validates :email_address, presence: true
  validates :email_address, uniqueness: true
  validates :email_address, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_secure_password
  has_many :locations
  has_many :playlists

  # def build_spotify_user(spotify_user)
  #   # binding.pry
  #   # spotify_user = RSpotify::User.new(auth) #stores user's spotify data as spotify_user
  #   business = self.find_or_create_by(email_address: spotify_user.email) #finds or creates new business object using spotify id
  #   business.uid = spotify_user.id
  #   spotify_user.playlists.each do |playlist| #begins iteration over each of spotify_user's playlist objects and
  #     s_playlist = Playlist.find_or_create_by(name: playlist.name.to_s) #creates a new Playlist for each object
  #     s_playlist.business = business #associates the Playlist with the business
  #     s_playlist.save #saves the Playlist object
  #       playlist.tracks.each do |track| #iterates over each track in the playlist
  #         song = Song.find_or_create_by(name: track.name, artist: track.artists.first.name, track_id: track.id) #creates a new Song object for each track in the playlist
  #         song.playlist = s_playlist #saves the song in the newly created playlist object
  #         s_playlist.songs << song #saves the song in the newly created playlist object
  #         s_playlist.save #saves the playlist
  #       end
  #     end
  #     binding.pry
  #     business.save
  # end
  # 
  # def auth
  #   request.env['omniauth.auth']
  # end

end
