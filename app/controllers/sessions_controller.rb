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

  end

  def create
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
