class LocationsController < ApplicationController
  before_action :require_login, :set_business

  def index
    if params[:state] == "All Locations"
      @locations = @business.locations.all
    elsif !params[:state].blank?
      @locations = @business.locations.by_state(params[:state])
    else
      @locations = @business.locations.all
    end
  end

  def new
    # binding.pry
    @location = Location.new
  end

  def create
    @location = Location.new(location_params)
    if @location.save
      redirect_to business_locations_path(@business)
    else
      render :new #renders with error messages
    end
  end

  def show
    @location = Location.find_by(id: params[:id])
  end

  def edit
    @location = Location.find_by(id: params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
    redirect_to business_location_path(@business, @location)
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to root_path
  end

  private

  def set_business
    if params[:state]
      @business = Business.find_by(id: session[:business_id])
    elsif
      params[:business_id].to_i == session[:business_id]
      @business = Business.find_by(id: params[:business_id])
    else
      redirect_to badurl_path
    end
  end

  def location_params
    params.require(:location).permit(:name, :address, :state, :business_id, :playlist_ids => [])
  end

end
