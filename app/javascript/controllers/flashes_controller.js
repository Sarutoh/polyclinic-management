import { Controller } from "@hotwired/stimulus"
import * as bootstrap from "bootstrap"

export default class extends Controller {
  connect() {
    var element = document.getElementById("toast-message");
    
    var toast = new bootstrap.Toast(element, {
        delay: 5000
    });
    toast.show();
  }
}

