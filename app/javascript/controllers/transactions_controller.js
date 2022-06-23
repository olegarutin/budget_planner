import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static values = { page: Number }

  connect() {
    $('.page-link').click(function() {
      document.getElementById('search_transactions_form').scrollIntoView();
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
    }
  }

  test() {
    document.getElementById('page_count').value = this.pageValue;
    // this.search(); # remove transaction not change wallet balance
  }

  showModal(e) {
    $('.button--green-border').removeClass('button--green-border');
    $('#AddTransaction').find('form').trigger('reset');
    $('#AddTransaction').modal('show');
    $('#transaction_errors').empty();
  }
}
