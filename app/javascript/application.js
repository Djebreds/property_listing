// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./jquery"
import * as bootstrap from "bootstrap"

$(document).on("turbolinks:load", function() {
  gtag('config', 'G-F7VG7THCLR', {'page_location': event.data.url});
})

window.initMap = function(...args) {
  const event = new CustomEvent("google-maps-callback", { bubbles: true, cancelable: true });
  event.args = args;
  window.dispatchEvent(event);
};
