class BusinessesController < ApplicationController

  before_action :require_login, except: [:spotify_user, :new, :create]

  def index
    if @business = Business.find_by(id: session[:business_id])
      render :show
    else
      redirect_to badurl_path
    end
  end

  def spotify_user
    spotify_user = RSpotify::User.new(auth) #retreives spotify users info

    if !session[:business_id] && !Business.find_by(uid: spotify_user.id) #if user is not logged and doesn't have an account already
      @business = Business.create(email_address: spotify_user.email) do |b| #creates new business object using spotify id
        b.uid = spotify_user.id #sets uid as spotify user id so later i can extend this app to allow for playback
        b.password = SecureRandom.urlsafe_base64 #generates a random password for spotify strategy
        b.name = spotify_user.display_name #sets name
      end
      session[:business_id] = @business.id
      build_playlists(@business)
      @business.save
      redirect_to business_path(@business)
    elsif !session[:business_id] && Business.find_by(uid: spotify_user.id) #user not logged in but they do have a spotify account linked to worknplay
      @business = Business.find_by(uid: spotify_user.id)
      session[:business_id] = @business.id
      redirect_to business_path(@business)
    elsif Business.find_by(id: session[:business_id]).uid == nil #if no spotify account is connected yet to current account
      if Business.find_by(uid: spotify_user.id)
        flash[:notice] = "Sorry, it looks like another user is already using that spotify account. Be sure to log out of that spotify account in any of your current browser windows in order to proceed."
        @business = Business.find_by(id: session[:business_id])
        redirect_to business_playlists_path(@business)
      else
        @business = Business.find_by(id: session[:business_id])
        @business.uid = spotify_user.id
        build_playlists(@business)
        @business.save
        redirect_to business_playlists_path(@business)
      end
    end
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
    if params[:business_id] == Business.find_by(id: session[:business_id]).id #ensures
      @business = Business.find_by(id: session[:business_id])
      @location = Location.new
    else
      redirect_to root_path
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
