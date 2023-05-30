import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  category_doctors (event) {
    let category_id = event.target.selectedOptions[0].value
  
    get(`/doctors/list?category_id=${category_id}`, {
      responseKind: 'turbo-stream'
    })
  }
}
