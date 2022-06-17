import { Controller } from '@hotwired/stimulus';
import Inputmask from 'inputmask';

export default class extends Controller {
  static targets = ['field']
  static values = { type: String }

  connect() {
    Inputmask({ placeholder: '', regex: this.regex }).mask(this.fieldTarget);
  }

  get regex() {
    if (this.typeValue == 'password') {
      return '^[A-Za-z0-9]+$';
    } else {
      return '^[0-9]*[.|,]?[0-9]{2}$';
    }
  }
}