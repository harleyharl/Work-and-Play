class LocationsController < ApplicationController
  before_action :require_login, :set_business, except: [:create]

  def index
    if params[:state] == "All Locations"
      @locations = @business.locations.all
      # respond_to do |f|
      #   f.html
      #   f.json {render json: @locations}
      # end
    elsif !params[:state].blank?
      @locations = @business.locations.by_state(params[:state])
      # respond_to do |f|
      #   f.html
      #   f.json {render json: @locations}
      # end
    else
      @locations = @business.locations.all
      # respond_to do |f|
      #   f.html
      #   f.json {render json: @locations}
      # end
    end
  end

  def new
    @location = Location.new
  end

  def create
    # binding.pry
    @location = Location.new(location_params)
    if @location.save
      # redirect_to business_locations_path(@business)
      render json: @location
    else
      render :new #renders with error messages
    end
  end

  def show
    @location = Location.find_by(id: params[:id])
    respond_to do |f|
      f.html
      f.json {render json: @location}
    end
  end

  def edit
    @location = Location.find_by(id: params[:id])
  end

  def update
    @location = Location.find(params[:id])
    @location.update(location_params)
    set_energy_levels(@location)
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
    elsif params[:business_id].to_i == session[:business_id]
      @business = Business.find_by(id: params[:business_id])
    else
      redirect_to badurl_path
    end
  end

  def set_energy_levels(location) # this is really bad and should definitely be in the model
    count = 0
    LocationPlaylist.all.each do |locationplaylist|
      if locationplaylist.location_id == location.id
        locationplaylist.energy = eval("params[:energy_level#{count}]")
        locationplaylist.save
        count += 1
      end
    end
  end

  def location_params
    params.require(:location).permit(:name, :address, :state, :business_id, :energy_level0, :energy_level1, :energy_level2, :energy_level3, :energy_level4, :playlist_ids => [])
  end

end
