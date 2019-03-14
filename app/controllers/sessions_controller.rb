class SessionsController < ApplicationController
  def index
    @business = Business.find_by(id: session[:business_id])

    if @business.id = session[:business_id]
      redirect_to business_path(@business)
    else
      redirect_to new_session_path
    end
  end

  def new
    # @business = Business.find_by(id: session[:business_id])
    #
    # if @business.id = session[:business_id] #checks if the user is logged in
    #   redirect_to business_path(@business) #redirects to the homepage if so
    # else
    #   redirect_to new_business_path #
    # end
  end

  def create
    # binding.pry
    if params[:email_address].blank?
      @business = Business.find_by(email_address: auth[:info][:email])
      session[:business_id] = @business.id
      redirect_to business_path(@business)
    elsif @business = Business.find_by(email_address: params[:email_address])
      @business.authenticate(params[:password])
      session[:business_id] = @business.id
      redirect_to business_path(@business)
    else
      flash[:notice] = "You have entered the wrong email or password. Please try again or sign up for an account"
      render :new
    end

    #spotify login
    # @business = Business.find_or_create_by(email_address: auth['email']) do |u|
    #   u.name = auth['info']['name']
    # end
    #
    # session[:business_id] = @business.id
    # redirect_to 'businesses/index'
  end

  def spotify
    # @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # @spotify_user = SpotifyUser.find_or_create_by(email_address: auth[:info][:email])
    # @spotify_user.name = auth[:info][:display_name]
    # binding.pry
    @business = Business.find_by(email_address: auth[:info][:email])
    session[:business_id] = @business.id
    redirect_to business_path(@business)
    # if @business.authenticate(params[:password])
    #   session[:business_id] = @business.id
    #   redirect_to business_path(@business)
    # else
    #   flash[:notice] = "You have entered the wrong email or password. Please try again or sign up for an account"
    #   render :new
    # end
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
