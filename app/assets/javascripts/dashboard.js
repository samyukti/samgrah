var Dashboard = function () {

  var displayTrend = function () {
    trend = $("#display_trend");
    $.plot(trend, [trend.data('chart')], {
      series: {
        lines: {
          show: true,
        }
      },
      xaxis: {
        mode: "categories",
        tickLength: 0
      }
    });
  };

  var displayShare = function () {
    share = $("#display_share");

    // $.plot(share, [{"label":"A","data":"1"},{"label":"B","data":"1"}], {
    $.plot(share, share.data('chart'), {
      series: {
        pie: {
          radius: 1,
          show: true,
          label: {
            show: true,
            radius: 3 / 4,
            formatter: function (label, series) {
              return '<div class="chart-label">' + series.data[0][1] + '</div>';
            },
            background: {
              opacity: 0.5
            }
          }
        }
      }
    });
  };

  return {
    index: function () {
      displayShare();
      displayTrend();
    },

    init: function () {}
  };

}();
