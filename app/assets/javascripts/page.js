var Page = function () {

  // Check whether the function is defined
  var isFunction = function (fn) {
    return (typeof(fn) == typeof(Function));
  };

  var initCap = function (str) {
    return str.charAt(0).toUpperCase() + str.substring(1);
  };

  return {
    //main function to initiate the module
    init: function () {
      // initialize the shadow script for controller+action
      var fController = initCap($('body').attr('app-controller'));
      var fAction     = $('body').attr('app-action');

      jQuery(document).ready(function () {

        if (window[fController] && isFunction(window[fController]['init'])) {
          window[fController]['init']();
        }
        if (window[fController] && isFunction(window[fController][fAction])) {
          window[fController][fAction]();
        }
      });

    }
  };

}();
