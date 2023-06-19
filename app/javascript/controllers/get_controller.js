import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

const turboStream = 'turbo-stream'
const slotRoute = 'slots'
const listRoute = 'list'
const doctorsController = 'doctors'
const patientsController = 'patients'

export default class extends Controller {
  categoryDoctors(event) {
    let categoryId = this.getId(event)
    let route = `/${doctorsController}/${listRoute}`
    let params = { categoryId: categoryId }
  
    get(this.getPath(route, params), { responseKind: turboStream })
  }

  doctorSlots(event) {
    let doctorId = this.getId(event)
    let route = `/${doctorsController}/${slotRoute}`
    let params = { doctorId: doctorId }

    get(this.getPath(route, params), { responseKind: turboStream })
  }

  patientSlots(event) {
    let patientId = this.getId(event)
    let route = `/${patientsController}/${slotRoute}`
    let params = { patientId: patientId }

    get(this.getPath(route, params), { responseKind: turboStream })
  }

  getId(event) {
    return event.target.selectedOptions[0].value
  }

  getPath(route, params) {
    let name = Object.keys(params)[0]

    return `${route}?${name}=${params[name]}`
  }
}
