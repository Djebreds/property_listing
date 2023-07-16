import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="get-place-google-maps"
export default class extends Controller {
  static values = {
    latitude: String,
    longitude: String
  }

  static targets = ["latitude", "longitude", "map"]
  connect() {
    if (typeof(google) != 'undefined') {
      this.initMap();
    }
  }

  initMap() {
    const latitude = this.latitudeValue
    const longitude = this.longitudeValue

    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(latitude, longitude),
      zoom: (this.latitudeValue == null ? 4 : 17)
    })

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
}
