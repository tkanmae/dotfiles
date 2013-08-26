// Use Vim keybindings.
$.getScript("/static/components/codemirror/keymap/vim.js", function() {
    if (! IPython.Cell) return;
    IPython.Cell.options_default.cm_config.keyMap = "vim";
});
