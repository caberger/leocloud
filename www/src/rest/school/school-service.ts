import { School } from "../../model/school/school"
import store from "../../model/store"

const urlParams = new URLSearchParams(window.location.search)
const apiURL = urlParams.get("api-url")
const baseURL = apiURL ? `./${apiURL}` : "./api"

export async function loadSchools() {
    const response = await fetch(`${baseURL}/school`)
    store.schools = await response.json() as School[]
}