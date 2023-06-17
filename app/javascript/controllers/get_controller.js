import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  categoryDoctors (event) {
    let category_id = event.target.selectedOptions[0].value
  
    get(`/doctors/list?category_id=${category_id}`, {
      responseKind: 'turbo-stream'
    })
  }

  doctorSlot (event) {
    let doctorId = event.target.selectedOptions[0].value

    get(`/doctors/slots?doctor_id=${doctorId}`, {
      responseKind: 'turbo-stream'
    })
  }
}
