class PlaylistsController < ApplicationController
  def index
    @business = Business.find_by(id: session[:business_id])
    # binding.pry
    @location = Location.find_by(id: params[:location_id])
    # @playlist = Playlist.new
    # RSpotify.authenticate(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
    # @party = RSpotify::Category.find('party')
    # @arctic_monkeys = RSpotify::Artist.find('7Ln80lUS6He07XvHI8qqHH')
  end

  def create
    # RSpotify.authenticate(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
  end

  def show
    #sessions create used to point here!
    # RSpotify.authenticate(ENV['CLIENT_ID'], ENV['CLIENT_SECRET'])
  end
end
