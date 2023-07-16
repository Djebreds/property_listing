import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="google-map-places"
export default class extends Controller {
  static targets = ["field", "map", "latitude", "longitude"]

  connect() {
    if (typeof(google) != "undefined") {
      this.initMap()
    }
  }

  initMap() {
    const latitude = this.data.get('latitude') || null
    const longitude = this.data.get('longitude') || null

    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(latitude, longitude),
      zoom: (this.data.get('latitude') == null ? 4 : 15)
    })

    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name'])
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))

    if (latitude && longitude == '0.0') {
      this.marker = new google.maps.Marker({
        map: this.map,
        ancorPoint: new google.maps.Point(0, -29),
      })
    } else {
      this.marker = new google.maps.Marker({
        map: this.map,
        position: new google.maps.LatLng(latitude, longitude),
        ancorPoint: new google.maps.Point(0, -29),
      })
    }
  }

  placeChanged() {
    let place = this.autocomplete.getPlace();

    if (!place.geometry) {
      window.alert(`No details available inputs: ${place.name}`);
      return
    }

    if (place.geometry.viewport) {
      this.map.fitBounds(place.geometry.viewport)
    } else {
      this.map.setCenter(place.geometry.location)
      this.map.setZoom(17)
    }

    this.marker.setPosition(place.geometry.location)
    this.marker.setVisible(true)

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
  }

  keydown(event) {
    if (event.key == 'Enter') {
      event.preventDefault()
    }
  }
}
