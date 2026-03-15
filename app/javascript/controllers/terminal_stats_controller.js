import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["modal", "ipDisplay", "countDisplay"]

    connect() {
        console.log("Terminal stats controller connected")
    }

    show(event) {
        if (event) event.preventDefault()

        const button = event.currentTarget
        const ip = button.dataset.ip

        console.log("TerminalStats#show triggered for IP:", ip)

        if (!this.hasModalTarget) {
            console.error("Modal target not found")
            return
        }

        if (this.hasIpDisplayTarget) {
            this.ipDisplayTarget.textContent = ip
        }

        if (this.hasCountDisplayTarget) {
            this.countDisplayTarget.textContent = "..."
        }

        this.modalTarget.classList.remove("hidden")
        this.modalTarget.classList.add("flex")

        fetch(`/terminal_accesses/stats?ip=${encodeURIComponent(ip)}`)
            .then(response => {
                if (!response.ok) throw new Error("Network response was not ok")
                return response.json()
            })
            .then(data => {
                console.log("Stats received:", data)
                if (this.hasCountDisplayTarget) {
                    this.countDisplayTarget.textContent = data.count
                }
            })
            .catch(error => {
                console.error("Error fetching stats:", error)
                if (this.hasCountDisplayTarget) {
                    this.countDisplayTarget.textContent = "!"
                }
            })
    }

    close(event) {
        if (event) event.preventDefault()
        console.log("Closing modal")
        this.modalTarget.classList.add("hidden")
        this.modalTarget.classList.remove("flex")
    }
}
