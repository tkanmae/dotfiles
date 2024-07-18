-- Delete Lazy.vim's default keymaps.

-- Buffers
vim.keymap.del("n", "<S-h>")
vim.keymap.del("n", "<S-l>")
vim.keymap.del("n", "<leader>bb")
vim.keymap.del("n", "<leader>`")

-- Move to an adjacent window
vim.keymap.del("n", "<C-h>")
vim.keymap.del("n", "<C-j>")
vim.keymap.del("n", "<C-k>")
vim.keymap.del("n", "<C-l>")

-- Resize windows
vim.keymap.del("n", "<C-Up>")
vim.keymap.del("n", "<C-Down>")
vim.keymap.del("n", "<C-Left>")
vim.keymap.del("n", "<C-Right>")

-- Manipulate windows
vim.keymap.del("n", "<leader>-")
vim.keymap.del("n", "<leader>|")

-- Emacs-like key mapping in insert and command mode
vim.keymap.set({ "i", "c" }, "<C-f>", "<Right>", { silent = true })
vim.keymap.set({ "i", "c" }, "<C-b>", "<Left>", { silent = true })
vim.keymap.set({ "i", "c" }, "<C-a>", "<Home>", { silent = true })
vim.keymap.set({ "i", "c" }, "<C-e>", "<End>", { silent = true })
vim.keymap.set({ "i", "c" }, "<C-d>", "<Del>", { silent = true })
vim.keymap.set({ "i" }, "<C-h>", "<BS>", { silent = true })
vim.keymap.set({ "i", "c" }, "<C-k>", "<Esc>lc$", { silent = true })

-- Move selected lines up and down
vim.keymap.set("v", "K", ":move '<-2<CR>gv-gv", { silent = true })
vim.keymap.set("v", "J", ":move '>+1<CR>gv-gv", { silent = true })

-- Change tmux pane
vim.keymap.set("n", "<C-t>j", function()
  require("user.tmux").select_pane("down")
end, { silent = true })
vim.keymap.set("n", "<C-t>k", function()
  require("user.tmux").select_pane("up")
end, { silent = true })
vim.keymap.set("n", "<C-t>l", function()
  require("user.tmux").select_pane("right")
end, { silent = true })
vim.keymap.set("n", "<C-t>h", function()
  require("user.tmux").select_pane("left")
end, { silent = true })
