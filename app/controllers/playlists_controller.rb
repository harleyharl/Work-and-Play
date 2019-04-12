class PlaylistsController < ApplicationController
  before_action :require_login

  def index
    @business = Business.find_by(id: session[:business_id])
    @location = Location.find_by(id: params[:location_id])
    @playlists = @business.playlists.all
  end


  def show
    if params[:location_id] #deals with different URLS - location_playlist or business_playlist
      @business = Business.find_by(id: session[:business_id])
      @location = Location.find_by(id: params[:location_id])
      @playlist = Playlist.find_by(id: params[:id])
    else
      @business = Business.find_by(id: session[:business_id])
      @playlist = Playlist.find_by(id: params[:id])
    end
  end


end
