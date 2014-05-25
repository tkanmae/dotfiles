"use strict";

// Load CodeMirror Add-ons.
$.getScript("/static/components/codemirror/addons/edit/closebrackets.js");

// Use Vim key bindings.
$.getScript("/static/components/codemirror/keymap/vim.js", function() {
  if (IPython.Cell) {
    IPython.Cell.options_default.cm_config.keyMap = "vim";
  }
});


// Enable line wrapping in CodeCell.
if (IPython.CodeCell) {
  IPython.CodeCell.options_default.cm_config.lineWrapping = true;
}


$([IPython.events]).on('app_initialized.NotebookApp', function() {
  if (window.marked) {
    window.marked.setOptions({smartypants: true});
  }

  // Handle <ESC> in the way Vim handles it.
  IPython.keyboard_manager.edit_shortcuts.add_shortcut('esc', function(event) {
    var cm = IPython.notebook.get_selected_cell().code_mirror;

    if (cm.state.vim) {
      if (cm.state.vim.insertMode) {
        CodeMirror.keyMap['vim-insert']['Esc'](cm);
        return false;
      }
    }
    IPython.notebook.command_mode();
    return false;
  });
});
