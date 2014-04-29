var Page = function () {

  // Check whether the function is defined
  var isFunction = function (fn) {
    return (typeof(fn) == typeof(Function));
  }

  return {
    //main function to initiate the module
    init: function () {
      // initialize the shadow script for controller+action
      fController = $('body').attr('app-controller');
      fAction     = $('body').attr('app-action');

      jQuery(document).ready(function () {

        if (window[fController] && isFunction(window[fController]["init"])) {
          window[fController]["init"]();
        }
        if (window[fController] && isFunction(window[fController][fAction])) {
          window[fController][fAction]();
        }
      });

    }
  };

}();
