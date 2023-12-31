import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="property-item-visibility"
export default class extends Controller {
  static targets = ["hideable"]

  toggleTargets() {
    this.hideableTargets.forEach((el) => {
      el.hidden = !el.hidden
    })
  }
}
