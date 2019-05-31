
$(() => {
  locationsClickHandler()
  }
)
//
// const filterClickHandler = () => {
//   $('#state_select').on('click', e => {
//     alert("yo!")
//     debugger
//     e.preventDefault()
//   })
// }

const locationsClickHandler = () => {
  $(`#my-locations`).on('click', e => {
    e.preventDefault()
    fetch(`${e.target.href}.json`)
    .then(res => res.json())
    .then(locations => {
      $(`#app-container`).html('')
      $(`#app-container`).append(filterHtml)
      locations.forEach(location => {
        let newLocation = new Location(location)
        let locationHtml = newLocation.formatLocationIndex()
        $(`#app-container`).append(locationHtml)
      })
      $(`#app-container`).append(addNewLocation)
    })
  })
}

let addNewLocation = `<a href="/businesses/1-harley-rayner/locations/new">Add a new location</a>`

function Location(location) {
  this.id = location.id
  this.name = location.name
  this.state = location.state
  this.address = location.address
}

Location.prototype.formatLocationIndex = function() {
  let locationHtml = `
  <div id=location-${this.id}>
    <h2> ${this.name} </h2>
    <p> ${this.address} - ${this.state} </p>
  </div>
  `
  return locationHtml
}


const filterHtml = `
    <div class="container text-center">
      <p>Filter locations by state</p>
      <form id="state_select" action="/locations" accept-charset="UTF-8" method="get"><input name="utf8" type="hidden" value="✓">
        <select id="state_select" name="state" ><option value="" label=" "></option><option value="All Locations">All Locations</option>
        <option value="AL">Alabama</option>
        <option value="AK">Alaska</option>
        <option value="AZ">Arizona</option>
        <option value="AR">Arkansas</option>
        <option value="CA">California</option>
        <option value="CO">Colorado</option>
        <option value="CT">Connecticut</option>
        <option value="DE">Delaware</option>
        <option value="DC">District of Columbia</option>
        <option value="FL">Florida</option>
        <option value="GA">Georgia</option>
        <option value="HI">Hawaii</option>
        <option value="ID">Idaho</option>
        <option value="IL">Illinois</option>
        <option value="IN">Indiana</option>
        <option value="IA">Iowa</option>
        <option value="KS">Kansas</option>
        <option value="KY">Kentucky</option>
        <option value="LA">Louisiana</option>
        <option value="ME">Maine</option>
        <option value="MD">Maryland</option>
        <option value="MA">Massachusetts</option>
        <option value="MI">Michigan</option>
        <option value="MN">Minnesota</option>
        <option value="MS">Mississippi</option>
        <option value="MO">Missouri</option>
        <option value="MT">Montana</option>
        <option value="NE">Nebraska</option>
        <option value="NV">Nevada</option>
        <option value="NH">New Hampshire</option>
        <option value="NJ">New Jersey</option>
        <option value="NM">New Mexico</option>
        <option value="NY">New York</option>
        <option value="NC">North Carolina</option>
        <option value="ND">North Dakota</option>
        <option value="OH">Ohio</option>
        <option value="OK">Oklahoma</option>
        <option value="OR">Oregon</option>
        <option value="PA">Pennsylvania</option>
        <option value="PR">Puerto Rico</option>
        <option value="RI">Rhode Island</option>
        <option value="SC">South Carolina</option>
        <option value="SD">South Dakota</option>
        <option value="TN">Tennessee</option>
        <option value="TX">Texas</option>
        <option value="UT">Utah</option>
        <option value="VT">Vermont</option>
        <option value="VA">Virginia</option>
        <option value="WA">Washington</option>
        <option value="WV">West Virginia</option>
        <option value="WI">Wisconsin</option>
        <option value="WY">Wyoming</option></select>
        <input id="state_select" type="submit" name="commit" value="Filter" data-disable-with="Filter">
      </form>
    </div>`
