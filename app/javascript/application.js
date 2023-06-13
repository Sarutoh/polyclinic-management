// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import * as bootstrap from "bootstrap"

import "./src/jquery"
import "./src/jquery-ui"

const toastElList = $('.toast')
const toastList = [...toastElList].map(toastEl => new bootstrap.Toast(toastEl))

$(function() {
    $("#selectable").selectable();
});
