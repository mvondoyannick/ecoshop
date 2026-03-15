import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["input", "row"]

    connect() {
        this.sortState = {}
    }

    search() {
        const query = this.inputTarget.value.toLowerCase()

        this.rowTargets.forEach(row => {
            const text = row.innerText.toLowerCase()
            row.classList.toggle("hidden", !text.includes(query))
        })
    }

    sort(event) {
        const column = event.currentTarget.dataset.column
        const index = Array.from(event.currentTarget.parentNode.children).indexOf(event.currentTarget)
        const type = event.currentTarget.dataset.type || "string"

        this.sortState[column] = this.sortState[column] === "asc" ? "desc" : "asc"
        const isAsc = this.sortState[column] === "asc"

        const sortedRows = this.rowTargets.sort((a, b) => {
            let valA = a.children[index].innerText.trim()
            let valB = b.children[index].innerText.trim()

            if (type === "number") {
                valA = parseFloat(valA.replace(/[^\d.-]/g, '')) || 0
                valB = parseFloat(valB.replace(/[^\d.-]/g, '')) || 0
            }

            if (valA < valB) return isAsc ? -1 : 1
            if (valA > valB) return isAsc ? 1 : -1
            return 0
        })

        const container = this.rowTargets[0].parentNode
        sortedRows.forEach(row => container.appendChild(row))

        // Update sort icons if needed
        this.updateIcons(event.currentTarget, isAsc)
    }

    updateIcons(header, isAsc) {
        // Reset other headers
        header.parentNode.querySelectorAll('svg').forEach(svg => svg.classList.add('opacity-20'))
        // Set current
        const icon = header.querySelector('svg')
        if (icon) {
            icon.classList.remove('opacity-20')
            icon.style.transform = isAsc ? 'rotate(0deg)' : 'rotate(180deg)'
        }
    }
}
