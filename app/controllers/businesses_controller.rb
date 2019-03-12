class BusinessesController < ApplicationController

  def index
    if !session[:business_id].blank?
      @business = Business.find_by(id: session[:business_id])
      redirect_to business_path(@business)
    else
      redirect_to new_business_path
    end
  end

  def new
    @business = Business.new
  end

  def create
    # binding.pry
    @business = Business.new(business_params)
    if @business.save
      session[:business_id] = @business.id
      # binding.pry
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
end
