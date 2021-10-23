/** example typescript module */

window.addEventListener("DOMContentLoaded", e => {
    let button = document.getElementById("github")
    console.log("content loaded", button)
    button.addEventListener("click", e => {
        window.location.href = "https://github.com/caberger/leocloud"
    })
})