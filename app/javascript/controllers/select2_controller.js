import { Controller } from '@hotwired/stimulus';
import Select2 from 'select2';

export default class extends Controller {
  connect() {
    Select2();
    $('#wallet_id').select2({
      dropdownParent: $('#AddTransaction')
    });

    $('#select_menu').select2({
      dropdownParent: $('#AddTransaction'),

      templateResult: formatState,
      templateSelection: formatState
    });

    function formatState (opt) {
      if (!opt.id) {
        return opt.text;
      }

      var optimage = $(opt.element).attr('data-image');

      if (!optimage){
         optimage = 'https://img.icons8.com/external-filled-outline-perfect-kalash/48/undefined/external-not-found-web-development-and-programming-filled-outline-perfect-kalash.png';
      }

      var $opt = $(
        '<span><img src="' + optimage + '" width="48px"/> ' + opt.text + '</span>'
      );
      return $opt;
    }
  }
}
