var Selectizer = function () {
  return {
    loadOptions: function (query, callback) {
      // if (!query.length) return callback();
      var selectize = this;
      var url = selectize.settings.remoteUrl;
      if (selectize.settings.initItem === true && selectize.settings.dataId) {
        url = url + '?id=' + selectize.settings.dataId;
      }
      $.ajax({
        url: url,
        type: 'GET',
        dataType: 'json',
        data: {
          s: query,
          per: 10
        },
        error: function() {
          callback();
        },
        success: function(data) {
          callback(data.options);
          if (selectize.settings.initItem === true && selectize.settings.dataId) {
            selectize.addItem(selectize.settings.dataId);
            selectize.settings.initItem = false;
          }
        }
      });
    },

    renderOptions: function (data, escape) {
      return '<div>' +
                '<img src="' + escape(data.image) + '" alt="' + data.name + '">' +
                '<span class="title">' +
                    '<span class="name">' + escape(data.name) + '</span>' +
                '</span>' +
                '<span class="code">' + escape(data.code) + '</span>' +
                '<span class="detail">' + escape(data.detail) + '</span>' +
            '</div>';
    }
  };
}();
