import { Controller } from '@hotwired/stimulus';
import Select2 from 'select2';

export default class extends Controller {
  connect() {
    Select2();
    $('#wallet_select_field').select2({
      dropdownParent: $('#AddTransaction')
    });

    $('#category_select_field').select2({
      dropdownParent: $('#AddCategory'),
      minimumResultsForSearch: -1,

      templateResult: createOption,
      templateSelection: createOption
    });

    function createOption(opt) {
      return  $('<span><img src="' + $(opt.element).attr('data-image') + '" width="48px"/></span>');
    }

    $('#category__filter').select2();
    $('#type__filter').select2();

    $('.transactions__filters').change(function(){
      document.getElementById('search_transactions_form').requestSubmit();
    });

    $('#select_menu').select2({
      dropdownParent: $('#AddTransaction'),

      templateResult: formatState,
      templateSelection: formatState
    });

    function formatState(opt) {
      if (!opt.id) {
        return opt.text;
      }

      let optimage = $(opt.element).attr('data-image');

      if (!optimage) {
        optimage = 'https://img.icons8.com/external-filled-outline-perfect-kalash/48/undefined/external-not-found-web-development-and-programming-filled-outline-perfect-kalash.png';
      }

      return $('<span><img src="' + optimage + '" width="48px"/> ' + opt.text + '</span>');
    }
  }
}
