import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['button']

  change(e) {
    this.buttonTargets.forEach(button => button.classList.remove('button--green-border'));
    e.target.classList.add('button--green-border');
  }

  resetModal() {
    $('#AddCategory').find('form').trigger('reset');
    $('#category_errors').empty();
    $('#transaction_errors').empty();
  }

  hideModal(e) {
    if (e.detail.success) {
      $('.button--green-border').removeClass('button--green-border');
      $('#AddTransaction').modal('show');
      $('#AddCategory').modal('hide');
    }
  }
}
