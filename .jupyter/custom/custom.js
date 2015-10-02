"use strict";

require(['base/js/namespace', 'base/js/events', 'base/js/utils'], function (IPython, events, utils) {
$([IPython.events]).on("notebook_loaded.Notebook", function () {
    IPython.CodeCell.options_default.cm_config.autoCloseBrackets = true;
  });
});
