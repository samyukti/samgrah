var Copies = function () {

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
        { "sortable": false, "render": renderActionLinks }
    ];
    Datatable.init('#datatable', varColumns);
  };

  var initForm = function () {
    var handleItemChange = function () {
      var id = $(this).val();
      if (id) {
        $.ajax({
          url: '/items/' + id + '.json',
          type: 'GET',
          dataType: 'json',
          success: function(data) {
            $('#copy_length').val(data.length);
            $('#copy_length_uom')[0].selectize.setValue(data.length_uom);
            $('#copy_format')[0].selectize.setValue(data.format);
            $('#copy_publisher').val(data.publisher);
            $('#copy_published_date').val(data.published_date);
            $('#copy_cost').val(data.cost);
            $('#copy_price').val(data.price);
          }
        });
      };
    };

    $('#copy_item_id').selectize({
        valueField: 'id',
        labelField: 'name',
        searchField: ['code', 'name'],
        create: false,
        render: { option: Selectizer.renderOptions },
        remoteUrl: '/items/select.json',
        dataId: $('#copy_item_id').data('id'),
        initItem: true,
        preload: true,
        load: Selectizer.loadOptions
    });

    $('#copy_item_id').change(handleItemChange);
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
