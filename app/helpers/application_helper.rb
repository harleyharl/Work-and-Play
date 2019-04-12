module ApplicationHelper
  def user_logged_in?
    !session[:business_id].blank?
  end
end
