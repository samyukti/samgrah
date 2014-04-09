var Selectizer = function () {
  return {
    loadOptions: function (query, callback) {
      if (!query.length) return callback();
      $.ajax({
        url: this.settings.remoteUrl,
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
          callback(data);
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
