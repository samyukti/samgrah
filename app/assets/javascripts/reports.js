var Report = function () {

  var show_copies_pivot = function () {
    var fields = [
        {name: 'ID',             type: 'integer',    rowLabelable: false},

        // filterable fields
        {name: 'Accession No',   type: 'string', filterable: true},
        {name: 'Category',       type: 'string', filterable: true},
        {name: 'Category Type',  type: 'string', filterable: true},
        {name: 'Item Code',      type: 'string', filterable: true},
        {name: 'Item Name',      type: 'string', filterable: true},
        {name: 'Item Type',      type: 'string', filterable: true},
        {name: 'Subject',        type: 'string', filterable: true},
        {name: 'Format',         type: 'string', filterable: true},
        {name: 'Language',       type: 'string', filterable: true, columnLabelable: true},
        {name: 'Publisher',      type: 'string', filterable: true},
        {name: 'Published Date', type: 'date',   filterable: true},
        {name: 'Rating',         type: 'string', filterable: true},
        {name: 'Quality',        type: 'string', filterable: true, columnLabelable: true},
        {name: 'Issued',         type: 'string', filterable: true, columnLabelable: true},
        {name: 'Status',         type: 'string', filterable: true, columnLabelable: true},
        {name: 'Location',       type: 'string', filterable: true},
        {name: 'Procured Date',  type: 'date',   filterable: true},

        // summary fields
        {name: 'Cost',           type: 'float',    rowLabelable: false, summarizable: 'sum'},
        {name: 'Price',          type: 'float',    rowLabelable: false, summarizable: 'sum'},
        {name: 'Quantity',       type: 'integer',  rowLabelable: false, summarizable: 'sum'},
      ];

    $(document).ready(function() {
      report_data = $('.report-data').text();
      input = { json: report_data,
                fields: fields,
                rowLabels: ['Category', 'Language'],
                summaries: ['Quantity']
              };

      $('#pivot-detail').pivot_display('setup', input);
      // prevent dropdown from closing after selection
      $('.stop-propagation').click(function(event){
        event.stopPropagation();
      });

      $('#filter-list select').addClass('form-control input-sm');
      $('#select-constructor').change(function () {
        $('#filter-list select').addClass('form-control input-sm');
      });


    });
  };

  var show_issues_pivot = function () {
    var fields = [
        {name: 'ID',            type: 'integer',    rowLabelable: false},

        // filterable fields
        {name: 'Copy',          type: 'string', filterable: true},
        {name: 'Item',          type: 'string', filterable: true},
        {name: 'Category',      type: 'string', filterable: true},
        {name: 'Type',          type: 'string', filterable: true, columnLabelable: true},
        {name: 'Language',      type: 'string', filterable: true, columnLabelable: true},
        {name: 'Member',        type: 'string', filterable: true},
        {name: 'Gender',        type: 'string', filterable: true, columnLabelable: true},
        {name: 'Age Group',     type: 'string', filterable: true, columnLabelable: true},
        {name: 'Membership',    type: 'string', filterable: true},
        {name: 'Status',        type: 'string', filterable: true, columnLabelable: true},
        {name: 'Issued Date',   type: 'date',   filterable: true},
        {name: 'Return Date',   type: 'date',   filterable: true},

        // summary fields
        {name: 'No of Days', type: 'integer',  rowLabelable: false, summarizable: 'sum'},
        {name: 'Count',      type: 'integer',  rowLabelable: false, summarizable: 'sum'},
      ];

    $(document).ready(function() {
      report_data = $('.report-data').text();
      input = { json: report_data,
                fields: fields,
                filters: {Status: 'Issued'},
                rowLabels: ['Copy', 'Item', 'Member'],
                summaries: ['Count']
              };

      $('#pivot-detail').pivot_display('setup', input);
      // prevent dropdown from closing after selection
      $('.stop-propagation').click(function(event){
        event.stopPropagation();
      });

      $('#filter-list select').addClass('form-control input-sm');
      $('#select-constructor').change(function () {
        $('#filter-list select').addClass('form-control input-sm');
      });


    });
  };

  var show_receipts_pivot = function () {
    var fields = [
        {name: 'ID',            type: 'integer',    rowLabelable: false},

        // filterable fields
        {name: 'Type',          type: 'string', filterable: true, columnLabelable: true},
        {name: 'Mode',          type: 'string', filterable: true, columnLabelable: true},
        {name: 'Member',        type: 'string', filterable: true},
        {name: 'Gender',        type: 'string', filterable: true, columnLabelable: true},
        {name: 'Age Group',     type: 'string', filterable: true, columnLabelable: true},
        {name: 'Membership',    type: 'string', filterable: true},
        {name: 'Status',        type: 'string', filterable: true, columnLabelable: true},
        {name: 'Received Date', type: 'date',   filterable: true},

        // summary fields
        {name: 'Amount',     type: 'float',    rowLabelable: false, summarizable: 'sum'},
        {name: 'Count',      type: 'integer',  rowLabelable: false, summarizable: 'sum'},
      ];

    $(document).ready(function() {
      report_data = $('.report-data').text();
      input = { json: report_data,
                fields: fields,
                filters: {Status: 'Approved'},
                rowLabels: ['Type', 'Mode', 'Member'],
                summaries: ['Amount']
              };

      $('#pivot-detail').pivot_display('setup', input);
      // prevent dropdown from closing after selection
      $('.stop-propagation').click(function(event){
        event.stopPropagation();
      });

      $('#filter-list select').addClass('form-control input-sm');
      $('#select-constructor').change(function () {
        $('#filter-list select').addClass('form-control input-sm');
      });


    });
  };

  var show_report = function () {
    report_name = $('.report-name').text();
    Report[report_name]();
  };

  return {
    index: function () {},

    show: function () {
      show_report();
    },

    copies: function () {
      show_copies_pivot();
    },

    issues: function () {
      show_issues_pivot();
    },

    receipts: function () {
      show_receipts_pivot();
    },

    daily_status: function () {},
    expired_memberships: function () {},
    overdue_issues: function () {},
    unavailable_copies: function () {},
  };

}();
