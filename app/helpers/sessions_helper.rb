module SessionsHelper
  def logged_in?
    !session[:business_id].blank?
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to new_business_path
    end
  end

end
