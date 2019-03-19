class LocationsController < ApplicationController

  def index
    # binding.pry
    if !session[:business_id].blank?
      @business = Business.find_by(id: session[:business_id])
    else
      redirect_to new_session_path
    end
  end

  def new
    @business = Business.find_by(id: session[:business_id])
    @location = Location.new
    # @location.playlists.build(time_slot: 1)
    # @location.playlists.build(time_slot: 2)
    # @location.playlists.build(time_slot: 3)
    # @location.playlists.build(time_slot: 4)
    # @location.playlists.build(time_slot: 5)
  end

  def create
    @business = Business.find_by(id: session[:business_id])
    @location = Location.new(location_params)
    if @location.save
      redirect_to business_locations_path(@business)
    else
      render :new
    end
  end

  def show
    @business = Business.find_by(id: session[:business_id])
    @location = Location.find_by(id: params[:id])
    # @playlist = Playlist.new
    # @location.playlists.build
  end

  def edit
    @business = Business.find_by(id: session[:business_id])
    @location = Location.find_by(id: params[:id])
    # @location.update(location_params)
    # redirect_to business_locations_path(@business)
  end

  def update
    @business = Business.find_by(id: session[:business_id])
    @location = Location.find(params[:id])
    @location.update(location_params)
    redirect_to business_locations_path(@business)
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to root_path
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :state, :business_id, :playlist_ids => [])
  end

end
