import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = [ 'button' ]

  change(e) {
    this.buttonTargets.forEach(button => button.classList.remove('btn-outline-success', 'border-success'));
    e.target.classList.add('btn-outline-success', 'border-success', 'select_button');
  }

  resetModal() {
    $('#AddCategory').find('form').trigger('reset');
    $('#category_errors').empty();
    $('#transaction_errors').empty();
  }

  hideModal(e) {
    if (e.detail.success) {
      $('.select_button').removeClass(['btn-outline-success', 'border-success', 'select_button']);
      $('#AddTransaction').modal('show');
      $('#AddCategory').modal('hide');
    }
  }
}
