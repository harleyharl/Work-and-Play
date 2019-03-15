class LocationsController < ApplicationController

  def index
    if !session[:business_id].blank?
      @business = Business.find_by(id: session[:business_id])
    else
      redirect_to new_session_path
    end
  end

  def new
    @business = Business.find_by(id: session[:business_id])
    @location = Location.new
  end

  def create
    # binding.pry
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
  end

  def destroy
    @location = Location.find(params[:id])
    @location.destroy
    redirect_to root_path
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :state, :business_id)
  end
end
