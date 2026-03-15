import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["streamContainer", "indicator", "toggleButton", "toggleCircle"]

    connect() {
        this.active = true
        this.updateUI()
    }

    toggle() {
        this.active = !this.active
        if (this.active) {
            this.activate()
        } else {
            this.deactivate()
        }
        this.updateUI()
    }

    activate() {
        const streamName = this.streamContainerTarget.dataset.streamName
        const streamTag = `<turbo-cable-stream-source channel="Turbo::StreamsChannel" signed-stream-name="${streamName}"></turbo-cable-stream-source>`
        this.streamContainerTarget.innerHTML = streamTag
    }

    deactivate() {
        this.streamContainerTarget.innerHTML = ""
    }

    updateUI() {
        if (this.indicatorTarget) {
            this.indicatorTarget.textContent = this.active ? "ON" : "OFF"
            this.indicatorTarget.classList.toggle("bg-green-500", this.active)
            this.indicatorTarget.classList.toggle("bg-gray-400", !this.active)
        }

        if (this.toggleButtonTarget) {
            this.toggleButtonTarget.classList.toggle("bg-green-600", this.active)
            this.toggleButtonTarget.classList.toggle("bg-gray-300", !this.active)
        }

        if (this.toggleCircleTarget) {
            this.toggleCircleTarget.classList.toggle("translate-x-5", this.active)
            this.toggleCircleTarget.classList.toggle("translate-x-0", !this.active)
        }
    }
}
