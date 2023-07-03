import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="list"
export default class extends Controller {
  setSlot () {
    let slotHour = $('.active').text();
    let slotDate = $('#appointment_date').val();

    $('#appointment_time_slot').val(slotDate + slotHour);
  }
}
