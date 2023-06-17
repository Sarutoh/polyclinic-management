import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="list"
export default class extends Controller {
  setSlot () {
    let slotValue = $('.active').text();

    $('#appointment_appointment_date').val(slotValue);
  }
}
