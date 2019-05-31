$(() => {
  bindClickHandlers()
})

const bindClickHandlers = () => {
  $(`.playlist`).on('click', e => {
    // debugger
    e.preventDefault()
    fetch(`${e.target.href}.json`) //uses the event's paremeters to get the link to fetch data from
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
}

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
