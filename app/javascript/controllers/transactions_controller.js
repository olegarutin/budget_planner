import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  connect() {
    $('.page-link').click(function() {
      document.getElementById('search_transactions_form').scrollIntoView(0);
    });
  }

  search() {
    clearTimeout(this.timeout);
    this.timeout = setTimeout(() => {
      document.getElementById('search_transactions_form').requestSubmit();
    }, 200);
  }

  reset() {
    $('#search_transactions_form').trigger('reset');
    this.search();
  }

  hideModal(e) {
    if (e.detail.success) {
      $('#AddTransaction').modal('hide');
      this.search();
      document.getElementById('search_transactions_form').scrollIntoView(0);
    }
  }

  setPage() {
    let count = document.getElementById('transactions_count').value;
    if (count == 1) {
      $('.prev .page-link')[0].click();
    } else {
      $('.active .page-link')[0].click();
    }
  }

  showModal(e) {
    $('.button--green-border').removeClass('button--green-border');
    $('#AddTransaction').find('form').trigger('reset');
    $('#AddTransaction').modal('show');
    $('#transaction_errors').empty();
  }
}
