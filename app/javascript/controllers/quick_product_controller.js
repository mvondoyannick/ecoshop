import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["modal", "form"]

    open(event) {
        event.preventDefault()
        this.modalTarget.classList.remove("hidden")
        this.modalTarget.classList.add("flex")
        document.body.classList.add("overflow-hidden")
    }

    close(event) {
        if (event) event.preventDefault()
        this.modalTarget.classList.add("hidden")
        this.modalTarget.classList.remove("flex")
        document.body.classList.remove("overflow-hidden")
    }

    handleSuccess(event) {
        const [data, status, xhr] = event.detail
        // Find all product selects and add the new product
        const selects = document.querySelectorAll('select[name*="[produit_id]"]')
        selects.forEach(select => {
            const option = new Option(data.name, data.id)
            select.add(option)
        })

        this.close()
        this.formTarget.reset()
    }

    handleError(event) {
        // Basic error handling
        alert("Erreur lors de la création du produit. Vérifiez les champs.")
    }
}
