import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [ 'button' ]

  change(e) {
    this.buttonTargets.forEach(button => button.classList.remove('btn-outline-success', 'border-success'));
    e.target.classList.add('btn-outline-success', 'border-success');
  }
}
