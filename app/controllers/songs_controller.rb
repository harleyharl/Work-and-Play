class SongsController < ApplicationController
  before_action :require_login
  before_action :set_business

  def destroy
    @playlist = Playlist.find_by(id: params[:playlist_id])
    Song.find_by(id: params[:song_id]).destroy
    @playlist.save
    redirect_to playlist_path(@playlist)
  end

  def more_songs_by_artist
    @songs = Song.more_songs_by_artist("Mt. Eden")
  end

  private

  def set_business
    @business = Business.find_by(id: session[:business_id])
  end

end
