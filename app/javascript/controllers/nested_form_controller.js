import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["template", "container"]
    static values = { wrapperSelector: String }

    connect() {
        console.log("Nested form controller connected")
    }

    add(event) {
        event.preventDefault()
        console.log("Adding new item...")
        const timestamp = new Date().getTime()
        const template = this.templateTarget.content.cloneNode(true)
        const tempDiv = document.createElement("div")
        tempDiv.appendChild(template)
        const content = tempDiv.innerHTML.replace(/NEW_RECORD/g, timestamp)
        this.containerTarget.insertAdjacentHTML('beforeend', content)

        // Dispatch an event so other controllers can know about the new item
        this.dispatch("add", { detail: { content: content, timestamp: timestamp } })
    }

    remove(event) {
        event.preventDefault()
        console.log("Removing item...")
        let wrapper = event.currentTarget.closest(".nested-fields") || event.target.closest(".nested-fields")

        if (!wrapper) return

        if (wrapper.dataset.newRecord === "true") {
            wrapper.remove()
        } else {
            const destroyInput = wrapper.querySelector("input[name*='_destroy']")
            if (destroyInput) destroyInput.value = "1"
            wrapper.classList.add("hidden")
        }
    }
}
