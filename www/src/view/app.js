import "@webcomponents/webcomponentsjs/webcomponents-loader"
import store from "Model/store"
import "./school/school-dialog"
import "./school/school-table"
import { html } from "Lib/html"
import styles from "Styles/styles"
import { loadSchools } from "Rest/school/school-service"

window.addEventListener("WebComponentsReady", e => {
    loadSchools()
})

const template = html`
${styles}
<style>
    .center {
        margin: 16px auto;
        width: 500px;
    }
</style>
<div class="w3-container w3-card">
    <div class="w3-panel w3-center">
        <school-dialog class="w3-modal">
        </school-dialog>
    </div>
</div>

<div class="w3-container">
    <div class="w3-panel center">
        <div class="w3-card-4 w3-animate-top">
            <div id="content">
                <school-table></school-table>
            </div>
        </div>
    </div>
    <div class="w3-panel center w3-animate-bottom">
        <hr class="w3-border-grey"/>
        <p class="w3-justify">Die Daten der obigen Tabelle wurden mit REST vom Applikationsserver geladen und die Daten der JSON - Antwort
            erst im Browser dynamisch mit Javascript als HTML-Tabelle dargestellt.<br/>
            Klicke auf eine Zeile und du siehst den Vorteil:
            Es gibt kein Neuladen und damit ein angenehmeres Arbeiten für den Benutzer  
            (<b>S</b>ingle <b>P</b>age <b>A</b>pplication).
        </p>
        <hr class="w3-border-grey"/>
    </div>
</div>
`
class AppComponent extends HTMLElement {
    connectedCallback() {
        const shadowRoot = this.attachShadow({mode: "open"})
        const content = template.content.cloneNode(true)
        shadowRoot.appendChild(content)
        const schoolTable = shadowRoot.querySelector("school-table")
        schoolTable.addEventListener("school-selected", e  => this.editSchool(e.detail.school))
        const schoolDialog = shadowRoot.querySelector("school-dialog")
        schoolDialog.addEventListener("save-school", e => this.saveSchool(e.detail.school))
    }
    editSchool(school) {
        store.currentSchoolId = school.id
        const schoolDialog = this.shadowRoot.querySelector("school-dialog")
        schoolDialog.style.display = "block"
    }
    saveSchool(school) {
        store.school = school
        alert(`TODO: save ${school.name} to server`)
    }
}
customElements.define("app-component", AppComponent)

