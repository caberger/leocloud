
import store from "Model/store"
import styles from "Styles/styles"
import { html } from "Lib/html"

const template = school => html`
    ${styles}
    <div class="w3-modal-content w3-card-4 w3-animate-opacity" id="dlg">
        <header class="w3-container w3-light-grey">
                <span id="close" class="w3-button w3-display-topright">&times;</span>
                <h2>Edit School ${school.name}</h2>
        </header>
        <div class="w3-container">
            <input id="name" type="text" placeholder="Name der Schule" value="${school.name}"/>
        </div>
        <div class="w3-container w3-border-top w3-padding-16">
            <button id="save" class="w3-btn w3-round w3-border" type="submit">Speichern</button>
            <button id="close-button" class="w3-btn w3-round w3-border" type="button" onclick="e => this.close()">Abbrechen</button>
        </div>
        <footer class="w3-container w3-light-grey">
            <p>Not saved to server (security)</p>
        </footer>
    </div>
`
class SchoolDialog extends HTMLElement {
    connectedCallback() {
        this.attachShadow({mode: "open"})
        store.model
            .map(model => model.currentSchoolId)
            .filter(id => !!id)
            .subscribe(schoolId => this.render(schoolId))
    }
    render(schoolId) {
        const shadowRoot = this.shadowRoot
        const school = store.state.schools[schoolId]
        const content = template(school).content.cloneNode(true)
        shadowRoot.innerHTML = ""
        shadowRoot.appendChild(content)
        const close = shadowRoot.getElementById("close")
        close.onlick = e => this.close(e)
        const closeButton = shadowRoot.getElementById("close-button")
        closeButton.addEventListener("click", e => this.close())
        shadowRoot.getElementById("save").addEventListener("click", e => this.save(e))
    }
    close() {
        this.style.display = "none"
    }
    save(e) {
        const school = {
            ...store.state.schools[store.state.currentSchoolId],
            name: this.shadowRoot.getElementById("name").value
        }
        this.dispatchEvent(new CustomEvent("save-school", {detail: {school}}))
        this.close()
    }
}

customElements.define("school-dialog", SchoolDialog)
