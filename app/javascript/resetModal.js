$('.modal').on('hidden.bs.modal', function () {
  $(this).find('form').trigger('reset');
  setTimeout(function () { $('#error').remove(); }, 2000);
});
