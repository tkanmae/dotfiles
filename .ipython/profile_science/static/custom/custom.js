"use strict";

$([IPython.events]).on('app_initialized.NotebookApp', function() {
  if (window.marked) {
    window.marked.setOptions({smartypants: true});
  }
});

if (IPython.CodeCell) {
  IPython.CodeCell.options_default.cm_config.lineWrapping = true;
}
