import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  resetModal() {
    $('#wallet_errors').empty();
    $('#AddWallet').find('form').trigger('reset');
  }

  hideModal(e) {
    if (e.detail.success) {
      $('#AddWallet').modal('hide');
    }
  }
}
