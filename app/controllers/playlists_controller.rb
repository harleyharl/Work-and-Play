class PlaylistsController < ApplicationController
  def index
    @business = Business.find_by(id: session[:business_id])
    @location = Location.find_by(id: params[:location_id])
  end

  def create
  end

  def show
    @business = Business.find_by(id: session[:business_id])
    @location = Location.find_by(id: params[:location_id])
    @playlist = Playlist.find_by(id: params[:id])
  end

  def destroy
    # binding.pry
    @location = Location.find_by(id: params[:location_id])
    Playlist.find_by(id: params[:id]).destroy
    redirect_to location_path(@location)
  end

end
