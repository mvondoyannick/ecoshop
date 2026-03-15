import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["checkbox", "content"]

    connect() {
        this.updateVisibility()
    }

    toggle() {
        this.updateVisibility()
    }

    updateVisibility() {
        if (!this.hasCheckboxTarget || !this.hasContentTarget) return

        if (this.checkboxTarget.checked) {
            this.contentTarget.classList.remove("hidden")
        } else {
            this.contentTarget.classList.add("hidden")
        }
    }
}
