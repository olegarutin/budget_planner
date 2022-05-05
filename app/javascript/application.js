// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import "./jquery.js"
import * as bootstrap from "bootstrap"
import "./charts.js"
import "./pie.js"


document.addEventListener("turbo:load", () => {
  var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'))
  var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
    return new bootstrap.Tooltip(tooltipTriggerEl)
  })
})