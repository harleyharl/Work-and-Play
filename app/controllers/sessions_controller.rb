class SessionsController < ApplicationController
  def index
    @business = Business.find_by(id: session[:business_id])

    if @business.id = session[:business_id]
      redirect_to business_path
    else
      redirect_to new_session_path
    end
  end

  def new
    @business = Business.find_by(id: session[:business_id])

    if @business.id = session[:business_id]
      redirect_to business_path(@business)
    else
      redirect_to new_session_path
    end
  end

  def create

    @business = Business.find_or_create_by(email_address: auth['email']) do |u|
      u.name = auth['info']['name']
    end

    session[:business_id] = @business.id
    redirect_to 'businesses/index'
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
