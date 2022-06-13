import { Controller } from '@hotwired/stimulus';
import Inputmask from "inputmask";

export default class extends Controller {
  static targets = ['field']

  connect() {
    Inputmask("99999").mask(this.fieldTarget);
  }
}