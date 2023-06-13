import * as bootstrap from "bootstrap"
import "./src/jquery"
import "./src/jquery-ui"

import "@hotwired/turbo-rails"
import "./controllers"

const toastElList = $('.toast')
const toastList = [...toastElList].map(toastEl => new bootstrap.Toast(toastEl))

$(function() {
    $("#selectable").selectable();
});
