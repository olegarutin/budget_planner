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
    this.walletTargets.forEach(wallet => wallet.classList.remove('border-success'));
    e.target.form.offsetParent.classList.add('border-success');
  }

  hideModal(e) {
    if (e.detail.success) {
      $('#AddWallet').modal('hide');
    }
  }
}
