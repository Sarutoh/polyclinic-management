import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  setAppoinmentDate () {
    let activeValue = $('.active').text()

    $("#appointment_appointment_date").val(activeValue)
  }
}
