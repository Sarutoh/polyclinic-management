import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

const turboStream = 'turbo-stream'

export default class extends Controller {
  categoryDoctors (event) {
    let categoryId = this.getId(event)
    let route = 'list'
    let params = { categoryId: categoryId }
  
    get(this.getPath(route, params), { responseKind: turboStream})
  }

  doctorSlots (event) {
    let doctorId = this.getId(event)
    let route = 'slots'
    let params = { doctorId: doctorId }

    get(this.getPath(route, params), { responseKind: turboStream})
  }

  getId(event) {
    return event.target.selectedOptions[0].value
  }

  getPath(route, params) {
    let name = Object.keys(params)[0]

    return `/doctors/${route}?${name}=${params[name]}`
  }
}
