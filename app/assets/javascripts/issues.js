var Issue = function () {

  var initForm = function () {
    $('#issue_copy_id').selectize({
        valueField: 'id',
        labelField: 'code',
        searchField: ['code', 'name'],
        create: false,
        render: { option: Selectizer.renderOptions },
        remoteUrl: '/copies/select.json',
        dataId: $('#issue_copy_id').data('id'),
        initItem: true,
        preload: true,
        load: Selectizer.loadOptions
    });

    $('#issue_member_id').selectize({
        valueField: 'id',
        labelField: 'name',
        searchField: ['code', 'name'],
        create: false,
        render: { option: Selectizer.renderOptions },
        remoteUrl: '/members/select.json',
        dataId: $('#issue_member_id').data('id'),
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
