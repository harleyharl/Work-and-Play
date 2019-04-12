class LocationsController < ApplicationController

  def index
    if helpers.user_logged_in?
      @business = Business.find_by(id: session[:business_id])
        if params[:state] == "All Locations"
          @locations = @business.locations.all
        elsif !params[:state].blank?
          @locations = @business.locations.by_state(params[:state])
        else
          @locations = @business.locations.all
        end
    else
      redirect_to new_session_path
  end

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
    @business = Business.find_by(id: session[:business_id])
    @location = Location.new
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
    # binding.pry
    @business = Business.find_by(id: session[:business_id])
    @location = Location.find_by(id: params[:id])
  end

  def edit
    @business = Business.find_by(id: session[:business_id])
    @location = Location.find_by(id: params[:id])
  end

  def update
    @business = Business.find_by(id: session[:business_id])
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

  def location_params
    params.require(:location).permit(:name, :address, :state, :business_id, :playlist_ids => [])
  end

end
