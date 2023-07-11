import * as bootstrap from "bootstrap"
import "./src/jquery"
import "./src/jquery-ui"
import "./src/jquery-ui-dp"
import "@hotwired/turbo-rails"
import "./controllers"

const toastElList = $('.toast')
const toastList = [...toastElList].map(toastEl => new bootstrap.Toast(toastEl))

$(document).on('change', function() {
    $("#selectable").selectable();
    $("#appointment_date").datepicker({
        defaultDate: "+1w",
        dateFormat: 'yy/mm/dd',
        changeMonth: false,
        numberOfMonths: 1,
        minDate: 0,
        maxDate: 14,
        beforeShowDay: $.datepicker.noWeekends
    });
});
