var businessDetails;
const timeSlots = ["6am-9am", "9am-12pm", "12pm-3pm", "3pm-6pm", "6pm-9pm"]
let timeSlotIndex = 0


fetch(`${window.origin}/show_json.json`) // gets the user's details and saves the into businessDetails variable
  .then(res => res.json())
  .then(data => businessDetails = data)

function Business(businessDetails){ //business class constructor
  this.id = businessDetails.id
  this.name = businessDetails.name
}

Business.prototype.urlSlug = function(){ //gets the businesses' base url *im never nesting my resources again....lesson learned
  let name = businessDetails.name.toLowerCase().replace(/[^a-z0-9]+/g,'-').replace(/(^-|-$)/g,'');
  let id = this.id
  return(id + '-' + name)
}

$(() => {
  bindClickHandlers()
})

const bindClickHandlers = () => { //repaints the dom with my music playlists (just the titles)
  $(`#my-music`).on('click', e => {
    e.preventDefault()
    fetch(`${e.target.href}.json`)
      .then(res => res.json())
      .then(playlists => {
        $(`#app-container`).html('')
        playlists.forEach(playlist => {
          let newPlaylist = (new Playlist(playlist))
          let playlistHtmlForMusicPage = newPlaylist.formatPlaylistForMusicPage()
          $(`#app-container`).append(playlistHtmlForMusicPage)
        })
      })
  })

  $(`#app-container`).on('click', '.playlist', function(e) { //event delegation so these events can be fired from our re-painted dom
    e.preventDefault()
    let business = new Business(businessDetails) //creates a new variable for the business
    fetch((`${e.target.origin}` + `/businesses/` + `${business.urlSlug()}` + `/playlists/${this.id[this.id.length -1]}.json`)) //builds out the url to fetch from for each playlist for the next fetch function to hook into
      .then(res => res.json())
      .then(playlist => {
        $(`#playlist-${playlist.id}`).html('') // clears out the playlist paragraph so it doesn't double-fill
        playlist.songs.forEach(song => {
          let newSong = new Song(song)
          let songHtml = newSong.formatIndex()
          $(`#playlist-${playlist.id}`).append(songHtml)
        })
      })
  })

  $(`.location`).on('click', e => { // repaints the dom with the locations index of playlists (this is the 'show requirement')
    e.preventDefault()
    fetch(`${e.target.href}.json`)
    .then(res => res.json())
    .then(location => {
      $(`#app-container`).html('')
      timeSlotIndex = 0
      location.playlists.forEach(playlist => {
        let newPlaylist = new Playlist(playlist)
        let playlistHtml = newPlaylist.formatPlaylist()
        $(`#app-container`).append(playlistHtml)
        timeSlotIndex++
      })
      $(`#app-container`).append(backToYourLocations)
    })
  })

  $(`#new_location`).on('submit', function(e) { //satisfies the form requirement
    e.preventDefault()
    serializedLocationValues = ($(this).serialize())// grabs values from form submit. 'this' is the form itself
    $.post('/locations', serializedLocationValues).done(function(data) {
      $('#app-container').html('')
      const newLocation = new Location(data)
      const newLocationHtml = newLocation.formatLocation()

      $('#app-container').html(newLocationHtml)
      // $('#app-container').append(backToYourLocations) //removed because link doesn't work properly for this page

    })
  })

}

function Playlist(playlist) {
  this.id = playlist.id
  this.name = playlist.name
  this.songs = playlist.songs
}

Playlist.prototype.formatPlaylistForMusicPage = function(){
  let playlistHtmlForMusicPage = `

    <h1>${this.name}</h1>

    <a class="playlist" id="playlist-${this.id}" href="#"> click for details </a>

  `
  return playlistHtmlForMusicPage
}

Playlist.prototype.formatPlaylist = function() {
  let playlistHtml = `
    <h1> ${this.name} </h1>
    <p> ${timeSlots[timeSlotIndex]} </p>
  `
  return playlistHtml
}

// below needs to be fixed because it doesn't work after creating a new location
let backToYourLocations = `
  <br>
  <br>
  <a id="back" href='${window.location.pathname}'>See your other locations</a>
`


function Song(song) {
  this.id = song.id
  this.name = song.name
  this.artist = song.artist
  this.track_id = song.track_id
}

Song.prototype.formatIndex = function() {
  let songHtml = `
    <li> ${this.artist} - ${this.name} </li>
  `
  return songHtml
}

function Location(location) {
  this.id = location.id
  this.name = location.name
  this.address = location.address
  this.state = location.state
}

Location.prototype.formatLocation = function(){
  let locationHtml = `
    <h2>${this.name}</h2>
    <p>${this.address}, ${this.state}</p>
  `
  return locationHtml
}
