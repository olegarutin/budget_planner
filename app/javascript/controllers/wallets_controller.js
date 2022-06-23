import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['wallet']

  resetModal() {
    $('#wallet_errors').empty();
    $('#AddWallet').find('form').trigger('reset');
  }

  selectWallet(e) {
    document.getElementById('search_transactions_form').reset();
    document.getElementById('wallet_list').value = e.target.form.id;
    this.moveClass(e.target.form.offsetParent);
  }

  selectAll(e) {
    this.moveClass(e.target);
    document.getElementById('wallet_list').value = '';
  }

  moveClass(target) {
    $('.wallet--green-border').removeClass('wallet--green-border');
    target.classList.add('wallet--green-border');
  }

  hideModal(e) {
    if (e.detail.success) {
      $('#AddWallet').modal('hide');
    }
  }
}
