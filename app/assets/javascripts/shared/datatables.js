var Datatable = function () {

  return {
    init: function (tableId, varColumns) {
      if (!jQuery().dataTable) {
          return;
      }

      $(document).ready(function() {
        var varTable = $('table' + tableId).DataTable({
          'columns': varColumns,
          'processing': true,
          'serverSide': true,
          'stateSave': true,
          'stateDuration': -1,
          'ajax': $(tableId).data('source'),
          'pagingType': 'full_numbers',
          'language': {
              'lengthMenu': '_MENU_ records per page',
              'paginate': {
                  'previous': 'Prev',
                  'next': 'Next'
              }
          }
        });

        // search
        $(tableId + '_wrapper .dataTables_filter input').unbind();
        $(tableId + '_wrapper .dataTables_filter input').bind('keyup', function(event) {
          if(event.which == 13) {
            event.preventDefault();
            varTable.search(this.value).draw();
          }
        });

        // styling
        $(tableId + '_wrapper .dataTables_filter input').addClass('input-dt-filter');
        $(tableId + '_wrapper .dataTables_length select').addClass('input-dt-length');
        $(tableId + '_wrapper .dataTables_length select').selectize();
      });
    }
  };
}();
