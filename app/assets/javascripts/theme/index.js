jQuery(document).ready(function($) {
  // slimscroll
  $('.slim-scroll').slimScroll({'color': '#aaaaaa',
                                'disable-fade-out': 'true',
                                'distance': '0',
                                'height': 'auto',
                                'size': '7px'});

  // selectize
  if ($.fn.selectize) {
    // $('.selectize').selectize();
    $('.selectize').each( function () {
      if ($(this).attr('autofocus') == 'autofocus') {
        $(this).selectize()[0].selectize.focus();
      } else {
        $(this).selectize();
      }
    });
  }

  // datepicker
  $('.datepicker-input').datepicker({
      todayBtn: "linked",
      todayHighlight: true
  });
});
