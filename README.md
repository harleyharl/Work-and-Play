# work-and-play
A "background music" app that allows businesses to easily curate the workplace mood with music in multiple locations using built-in and imported playlists


Work and Play Application Summary

My application will be based on an app used by many businesses to play music at their work locations called SoundTrackYourBrand. This web app allows businesses to quickly create playlists by using a built-in, curated database of music and playlists, and allows for importing playlists from spotify. Users can then schedule playlists for multiple locations and monitor the music being played ensuring a cohesive, non-repetitive soundtrack across all locations with minimal interaction required from employees.

My application will come with built in playlists (which I will pre-import from spotify) that can be filtered through by genre using a scope method on the schedule building page.

It will also allow for importing of playlists from spotify using a gem called rspotify (A ruby wrapper for the Spotify Web API) and will implement user authentication through spotify with omniauth.

Models

Business/User:
has many locations
has many playlists

rails g model Business name:string email_address:string password:string —no-test-framework

validations:
email presence & uniqueness


Location:
belongs to a business
has many playlists, through schedules

rails g model Location name:string address:string —no-test-framework

validations:
address must be unique
region and status presence

Playlist
has many songs
belongs to a business
has many schedules

rails g model Playlist name:string —no-test-framework

validations:
length less than 10 hours

Song
has many playlists

validations:
has artist
has title
length less than 5 minutes

rails g model Song name:string artist:string duration:

URLs

home - worknplay.com/:business
here you get an overview of your locations and what playlist is currently playing at each location. link provided to click on each location. link provided to create a new playlist

playlists - worknplay.com/:business/:playlists/
here you can create or import new playlists

locations - worknplay.com/:bunsiness/:locations
here you can see each location and create a new location. you can click on each existing location, which will take you to that location’s show page
