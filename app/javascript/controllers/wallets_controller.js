import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['wallet']

  resetModal() {
    $('#wallet_errors').empty();
    $('#AddWallet').find('form').trigger('reset');
  }

  selectWallet(e) {
    $('#wallet').value = e.target.form.id;
    this.walletTargets.forEach(wallet => wallet.classList.remove('border-success'));
    e.target.form.classList.add('border-success');
  }

  hideModal(e) {
    if (e.detail.success) {
      $('#AddWallet').modal('hide');
    }
  }
}
