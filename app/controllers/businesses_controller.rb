class BusinessesController < ApplicationController

  def index
    if !session[:business_id].blank?
      @business = Business.find_by(id: session[:business_id])
      redirect_to business_locations_path(@business)
    else
      redirect_to new_session_path
    end
  end

  def spotify_user
    # binding.pry
    spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    @business = Business.find_or_create_by(id: spotify_user.id) do |b|
      b.email_address = spotify_user.email
      b.name = spotify_user.display_name
    end
    # binding.pry
    @business.playlists = spotify_user.playlists.each do |playlist|
      s_playlist = Playlist.new(name: playlist.name)
      s_playlist.business = @business
      s_playlist.save
        playlist.tracks.each do |track|
          song = Song.new(name: track.name, artist: track.artists.first.name)
          s_playlist.songs << song
          s_playlist.save
        end
      end
      binding.pry
    session[:id] = @business.id
    redirect_to business_locations_path(@business)
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
    @business = Business.find_by(id: session[:business_id])
    @location = Location.new
  end

  private

  def business_params
    params.require(:business).permit(:name, :email_address, :password, :password_confirmation)
  end

  def auth
    request.env['omniauth.auth']
  end

end
