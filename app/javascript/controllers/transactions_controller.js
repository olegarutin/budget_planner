import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      document.getElementById('search_transactions_form').requestSubmit();
    }, 200);
  }

  reset() {
    $('#search_transactions_form').trigger('reset');
  }

  modalHide(e) {
    if (e.detail.success) {
      $('#AddTransaction').modal('hide');
      this.search();
    }
  }

  modalShow(e) {
    $('.select_button').removeClass(['btn-outline-success', 'border-success', 'select_button']);
    $('#AddTransaction').find('form').trigger('reset');
    $('#AddTransaction').modal('show');
    $('#transaction_errors').empty();
  }
}
