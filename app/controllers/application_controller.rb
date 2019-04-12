class ApplicationController < ActionController::Base

  private

  def logged_in?
    !session[:business_id].blank?
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to login_path # halts request cycle
    end
  end
end
