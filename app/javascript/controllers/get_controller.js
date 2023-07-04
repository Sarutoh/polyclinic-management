import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

const turboStream = 'turbo-stream'
const slotRoute = 'slots'
const listRoute = 'list'

export default class extends Controller {
  categoryDoctors(event) {
    let categoryId = event.target.selectedOptions[0].value
    let route = listRoute
    let params = { categoryId: categoryId }
  
    get(this.getPath(route, params), { responseKind: turboStream })
  }

  userSlots() {
    let doctorId = $('#appointment_doctor_id').val()
    let patientId = $('#appointment_patient_id').val()
    let date = $('#appointment_date').val()

    let route = slotRoute
    let params = { doctorId: doctorId, patientId: patientId, date: date }
    console.log(doctorId, patientId, date)

    get(this.getPath(route, params), { responseKind: turboStream })
  }

  getPath(route, params) {
    return `/users/${route}?${this.paramsHandler(params)}`
  }

  paramsHandler(params) {
    var resultParams = ''

    for (let key in params) {
      resultParams += `${key}=${params[key]}&`
    }
    
    return resultParams.slice(0, -1)
  }
}
