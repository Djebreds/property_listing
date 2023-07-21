import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="get-all-property-places"
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
    const latitudeData = JSON.parse(this.latitudeTarget.getAttribute("data-get-all-property-places-latitude-value"));
    const longitudeData = JSON.parse(this.longitudeTarget.getAttribute("data-get-all-property-places-longitude-value"));

    // Assuming the first property as the map's center
    const initialLatitude = latitudeData[0];
    const initialLongitude = longitudeData[0];

    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(initialLatitude, initialLongitude),
      zoom: 6,
    });

    latitudeData.forEach((latitude, index) => {
      const longitude = longitudeData[index];
      const position = new google.maps.LatLng(latitude, longitude);

      new google.maps.Marker({
        position,
        map: this.map,
        anchorPoint: new google.maps.Point(0, -29),
      });
    });
  }
}
