import * as bootstrap from "bootstrap"
import "./src/jquery"
import "@hotwired/turbo-rails"
import "./controllers"
import "./src/jquery-ui"
import "./src/jquery-ui-dp"

const toastElList = $('.toast')
const toastList = [...toastElList].map(toastEl => new bootstrap.Toast(toastEl))

$(document).on('change', function() {
    $("#selectable").selectable();
});

$(function () {
    $("#appointment_date").datepicker({
        defaultDate: "+1w",
        dateFormat: 'dd/mm/yy',
        changeMonth: false,
        numberOfMonths: 1,
        minDate: 0,
        maxDate: 14,
        beforeShowDay: $.datepicker.noWeekends
    });
});
