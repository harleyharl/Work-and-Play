# require 'pry'
#
# binding.pry
#
# Rails.application.credentials.spotify[:client_id] = e2943b10cba34b5daf7ccd0e42415808
# Rails.application.credentials.spotify[:client_secret] = 98c79e163092423f9baa1fe466c802f5
#
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :spotify, Rails.application.credentials.spotify[:client_id], Rails.application.credentials.spotify[:client_secret], scope: %w(
#     playlist-read-private
#     user-read-private
#     user-read-email
#   ).join(' ')
# end
require 'rspotify/oauth'

#rspotify strategy
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], scope: 'playlist-read-private user-read-email playlist-modify-public user-library-read user-library-modify', :provider_ignores_state => true
end

# require 'omniauth-spotify'
#omniauth strategy
# Rails.application.config.middleware.use OmniAuth::Builder do
#   provider :spotify, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'], scope: %w(
#       playlist-read-private
#       user-read-private
#       user-read-email
#     ).join(' '), :provider_ignores_state => true
#
# end
