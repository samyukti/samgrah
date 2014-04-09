var Reservation = function () {

  var initForm = function () {
    $select_item = $('#reservation_item_id').selectize({
      valueField: 'id',
      labelField: 'name',
      searchField: ['code', 'name'],
      create: false,
      render: { option: Selectizer.renderOptions },
      remoteUrl: '/items/select.json',
      load: Selectizer.loadOptions
    });
    $select_item[0].selectize.focus();

    $('#reservation_member_id').selectize({
      valueField: 'id',
      labelField: 'name',
      searchField: ['code', 'name'],
      create: false,
      render: { option: Selectizer.renderOptions },
      remoteUrl: '/members/select.json',
      load: Selectizer.loadOptions
    });

    $(document).on('selectize:load', function(event){
      console.log(event);
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
