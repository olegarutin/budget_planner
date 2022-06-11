import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [ 'button' ]

  change(e) {
    this.buttonTargets.forEach(button => button.classList.remove('btn-outline-success', 'border-success'));
    e.target.classList.add('btn-outline-success', 'border-success', 'select_button');
  }

  resetModal() {
    console.log('dfdf');
    $('#AddCategory').find('form').trigger('reset');
    $('#transaction_errors').empty();
  }

  modalHide(e) {
    if (e.detail.success) {
      $('.select_button').removeClass(['btn-outline-success', 'border-success', 'select_button']);
      $('#AddTransaction').modal('show');
      $('#AddCategory').modal('hide');
    }
  }
}
