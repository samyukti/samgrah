var Receipts = function () {

  var renderActionLinks = function (data, type, row) {
    var linkShow = data.show ? '<a href="' + data.show + '"> \
                                  <span class="btn-xs btn-info"> \
                                    <i class="fa fa-search"></i> \
                                  </span> \
                                </a>' : '';

    var linkEdit = data.edit ? '<a href="' + data.edit + '"> \
                                  <span class="btn-xs btn-primary"> \
                                    <i class="fa fa-pencil"></i> \
                                  </span> \
                                </a>' : '';

    return linkShow +  '<span class="spacer"></span>' + linkEdit;
  };

  var initTable = function () {
    varColumns = [
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        { "sortable": false, "render": renderActionLinks }
    ];
    Datatable.init('#datatable', varColumns);
  };

  var initForm = function () {
    $select_member = $('#receipt_member_id').selectize({
      valueField: 'id',
      labelField: 'name',
      searchField: ['code', 'name'],
      create: false,
      render: { option: Selectizer.renderOptions },
      remoteUrl: '/members/select.json',
      load: Selectizer.loadOptions
    });
    $select_member[0].selectize.focus();
  };

  return {
    index: function () {
      initTable();
    },

    new: function () {
      initForm();
    },

    create: function () {
      initForm();
    },

    edit: function () {
      initForm();
    },

    update: function () {
      initForm();
    },

    show: function () {},

    init: function () {
    }
  };

}();
