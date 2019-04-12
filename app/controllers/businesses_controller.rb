class BusinessesController < ApplicationController

  def index
    if helpers.user_logged_in?
      @business = Business.find_by(id: session[:business_id])
      redirect_to business_path(@business)
    else
      redirect_to new_business_path
    end
  end

  def spotify_user
    spotify_user = RSpotify::User.new(auth) #stores user's spotify data as spotify_user

    @business = Business.find_or_create_by(email_address: spotify_user.email) do |b| #finds or creates new business object using spotify id
      b.uid = spotify_user.id #sets uid as spotify user id so later i can extent this app to allow for playback
      b.password = SecureRandom.urlsafe_base64 #generates a random password for spotify strategy
      b.name = spotify_user.display_name #sets name
    end

    build_playlists(@business)
    @business.save
    session[:business_id] = @business.id
    redirect_to business_path(@business)
  end

  def new
    if @business = Business.find_by(id: session[:business_id])
      redirect_to business_path(@business)
    else
      @business = Business.new
    end
  end

  def create
    @business = Business.new(business_params)
    if @business.save
      session[:business_id] = @business.id
      redirect_to business_path(@business)
    else
      render :new
    end
  end


  def show
    if helpers.user_logged_in?
      @business = Business.find_by(id: session[:business_id])
      @location = Location.new
    else
      redirect_to new_business_path
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :email_address, :password, :password_confirmation)
  end

  def auth
    request.env['omniauth.auth']
  end

  def build_playlists(business)
    RSpotify::User.new(auth).playlists.each do |playlist| #begins iteration over each of spotify_user's playlist objects and
      s_playlist = Playlist.find_or_create_by(name: playlist.name.to_s) #creates a new Playlist for each object
      s_playlist.business = business #associates the Playlist with the business
      s_playlist.save #saves the Playlist object
        playlist.tracks.each do |track| #iterates over each track in the playlist
          song = Song.find_or_create_by(name: track.name, artist: track.artists.first.name, track_id: track.id) #creates a new Song object for each track in the playlist
          song.playlist = s_playlist #saves the song in the newly created playlist object
          s_playlist.songs << song #saves the song in the newly created playlist object
          s_playlist.save #saves the playlist
        end
      end
  end

end
