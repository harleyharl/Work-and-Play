class LocationsController < ApplicationController

  def new
    @business = Business.find_by(id: session[:business_id])
    @location = Location.new
  end

  def create
    # binding.pry
    @business = Business.find_by(id: session[:business_id])
    @location = Location.new(location_params)
    if @location.save
      redirect_to business_path(@location.business)
    else
      render :new
    end
  end

  def show
    @business = Business.find_by(id: session[:business_id])
    @location = Location.find_by(id: params[:id])
  end

  private

  def location_params
    params.require(:location).permit(:name, :address, :business_id)
  end
end
