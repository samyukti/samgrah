var Copy = function () {

  var initForm = function () {
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
  };

  return {
    index: function () {},

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
