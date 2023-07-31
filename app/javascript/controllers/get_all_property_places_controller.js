import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="get-all-property-places"
export default class extends Controller {
  static values = {
    latitude: String,
    longitude: String,
    name: String,
    location: String,
    kindName: String,
    rentalName: String,
    rprice: String,
    kprice: String,
    category: String,
    type: String,
  }
  static targets = ["latitude", "longitude", "map", "name", "location", "kindName", "rentalName", "rprice", "kprice", "category", "type"]

  connect() {
    if (typeof(google) != 'undefined') {
      this.initMap();
    }
  }

  initMap() {
    const latitudeData = JSON.parse(this.latitudeTarget.getAttribute("data-get-all-property-places-latitude-value"));
    const longitudeData = JSON.parse(this.longitudeTarget.getAttribute("data-get-all-property-places-longitude-value"));
    const nameData = JSON.parse(this.nameTarget.getAttribute("data-get-all-property-places-name-value"));
    const categoryData = JSON.parse(this.categoryTarget.getAttribute("data-get-all-property-places-category-value"));
    const typeData = JSON.parse(this.typeTarget.getAttribute("data-get-all-property-places-type-value"));
    const locationData = JSON.parse(this.locationTarget.getAttribute("data-get-all-property-places-location-value"));
    const rentalNameData = JSON.parse(this.rentalNameTarget.getAttribute("data-get-all-property-places-rental-name-value"));
    const kindNameData = JSON.parse(this.kindNameTarget.getAttribute("data-get-all-property-places-kind-name-value"));
    const rpriceData = JSON.parse(this.rpriceTarget.getAttribute("data-get-all-property-places-rprice-value"));
    const kpriceData = JSON.parse(this.kpriceTarget.getAttribute("data-get-all-property-places-kprice-value"));

    // Assuming the first property as the map's center
    const initialLatitude = latitudeData[0];
    const initialLongitude = longitudeData[0];

    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(initialLatitude, initialLongitude),
      zoom: 6,
    });

    latitudeData.forEach((latitude, index) => {
      const longitude = longitudeData[index];
      const name = nameData[index];
      const location = locationData[index];
      const rentalName = rentalNameData;
      const kindName = kindNameData;
      const category = categoryData[index];
      const type = typeData[index];
      const rentalPrice = rpriceData[index];
      const kindPrice = kpriceData[index];

      const content =
      `
        <div id="content">
          <div id="siteNotice"></div>
          <h3 id="firstHeading" class="firstHeading" style="margin-bottom: 0px;">${name}</h3>
          <p class="secondHeading" style="margin-top: 0px;">${category} | ${type}</p>
          ${rentalName != "" ?
            `<h3 class="secondHeading" style="margin-bottom: 0px;">${rentalPrice}</h3>
             <h5 class="secondHeading" style="margin-bottom: 5px;">${rentalName}</h5>` : ''
          }
          ${kindName != "" ?
            `<h3 class="secondHeading" style="margin-bottom: 0px;">${kindPrice}</h3>
            <h5 class="fourHeading" style="margin-bottom: 5px;">${kindName}</h5>` : ''
          }
          <div id="bodyContent">
            ${location}
          </div>
        </div>
      `

      const position = new google.maps.LatLng(latitude, longitude);

      const infowindow = new google.maps.InfoWindow({
        content: content,
        maxWidth: 200,
        ariaLable: name,
      })

      const marker = new google.maps.Marker({
        position,
        map: this.map,
        anchorPoint: new google.maps.Point(0, -29),
      });

      marker.addListener("click", () => {
        infowindow.open({
          anchor: marker,
          map,
        });
      })
    });
  }
}
