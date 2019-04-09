
require 'rspotify/oauth'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :spotify, ENV['CLIENT_ID'], ENV['CLIENT_SECRET'],
  scope: 'playlist-read-private user-read-email playlist-modify-public user-library-read user-library-modify',
  :provider_ignores_state => true
end
