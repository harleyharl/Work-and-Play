class PlaylistsController < ApplicationController
  before_action :require_login, :set_business, except: [:show]

  def index
    @location = Location.find_by(id: params[:location_id])
    @playlists = @business.playlists.all
  end


  def show
    @business = Business.find_by(id: session[:business_id])
    if params[:location_id] #deals with different URLS - location_playlist or business_playlist
      @location = Location.find_by(id: params[:location_id])
      @playlist = Playlist.find_by(id: params[:id])
    else
      @playlist = Playlist.find_by(id: params[:id])
    end
  end

  private

  def set_business
    if params[:business_id].to_i == session[:business_id]
      @business = Business.find_by(id: params[:business_id])
    else
      redirect_to badurl_path
    end
  end


end
