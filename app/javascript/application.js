import * as bootstrap from "bootstrap"
import "./src/jquery"
import "@hotwired/turbo-rails"
import "./controllers"
import "./src/jquery-ui"

const toastElList = $('.toast')
const toastList = [...toastElList].map(toastEl => new bootstrap.Toast(toastEl))

$(document).on('change', function() {
    $("#selectable").selectable();
});
