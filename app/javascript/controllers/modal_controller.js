import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="modal"
export default class extends Controller {
  submitEnd(e) {
    if (e.detail.success) {
      this.hide()
    }
  }

  hide() {
    this.element.remove()
  }
}
