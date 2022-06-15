import { Controller } from '@hotwired/stimulus';
import Select2 from 'select2';

export default class extends Controller {
  connect() {
    Select2();
    $('#select_menu').select2({
      dropdownParent: $('#AddTransaction'),

      templateResult: formatState,
      templateSelection: formatState
    });

    function formatState (opt) {
      if (!opt.id) {
        return opt.text.toUpperCase();
      }

      var optimage = $(opt.element).attr('data-image');

      if (!optimage){
        return opt.text.toUpperCase();
      } else {

        var $opt = $(
          '<span><img src="' + optimage + '" width="48px"/> ' + opt.text + '</span>'
        );
        return $opt;
      }
    }
  }
}