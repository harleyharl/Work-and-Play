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
  end

  def create
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
  end

  def spotify
    binding.pry
    @business = Business.find_by(email_address: auth[:info][:email]) #email the user signed up with must match email they use with spotify!
    session[:business_id] = @business.id

    @spotify_user = RSpotify::User.new(request.env['omniauth.auth'])
    # @spotify_user.to_hash
    ["birthdate","country","display_name","email","followers","images","product","external_urls","href","id","type","uri","credentials"]
    # Then recover the Spotify user whenever you like
    @spotify_user = RSpotify::User.new(hash)


    redirect_to business_locations_path(@business)
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
