import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

const turboStream = 'turbo-stream'
const slotRoute = 'slots'
const listRoute = 'list'

export default class extends Controller {
  categoryDoctors(event) {
    let categoryId = this.getId(event)
    let route = listRoute
    let params = { categoryId: categoryId }
  
    get(this.getPath(route, params), { responseKind: turboStream })
  }

  userSlots(event) {
    let doctorId = this.getId(event)
    // let patientId = this.getId(event)
    let route = slotRoute
    let params = { doctorId: doctorId }

    get(this.getPath(route, params), { responseKind: turboStream })
  }

  getId(event) {
    return event.target.selectedOptions[0].value
  }

  getPath(route, params) {
    let name = Object.keys(params)[0]

    return `/users/${route}?${name}=${params[name]}`
  }
}
