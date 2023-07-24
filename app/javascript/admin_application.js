// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"

window.initMap = function(...args) {
  const event = new CustomEvent("google-maps-callback", { bubbles: true, cancelable: true });
  event.args = args;
  window.dispatchEvent(event);
};
