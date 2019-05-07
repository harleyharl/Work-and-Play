class SessionsController < ApplicationController
  def index
    @business = Business.find_by(id: session[:business_id])
    if @business.id = session[:business_id]
      redirect_to business_path(@business)
    else
      redirect_to login_path
    end
  end

  def new
  end

  def create
    if params[:email_address].blank? || params[:password].blank?
      flash[:notice] = "Looks like you've forgotten to enter your email address or password. Please try again or sign up for an account"
      render :new
    elsif @business = Business.find_by(email_address: params[:email_address])
      if @business.authenticate(params[:password])
        session[:business_id] = @business.id
        redirect_to business_locations_path(@business)
      else
        flash[:notice] = "You have entered the wrong email or password. Please try again or sign up for an account"
        render :new
      end
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
