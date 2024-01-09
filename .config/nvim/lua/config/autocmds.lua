-- Remove LazyVim's default autocmds.
vim.api.nvim_create_augroup("wrap_spell", { clear = true })

-- Prose editing
vim.api.nvim_create_augroup("prose_editing", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "prose_editing",
  pattern = { "txt", "markdown", "asciidoc", "rst", "pandoc" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.smartindent = false
    vim.opt_local.wrap = true
  end,
})

-- Restrict a text width to 72 characters in Git commmit message.
vim.api.nvim_create_augroup("gitcommit", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "gitcommit",
  pattern = { "gitcommit" },
  callback = function()
    vim.opt_local.textwidth = 72
  end,
})

-- Preview a Markdown file with Marked 2 on macO.
vim.api.nvim_create_augroup("open_with_marked", { clear = true })
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = "open_with_marked",
  pattern = { "markdown" },
  callback = function()
    if vim.fn.has("macunix") then
      vim.keymap.set(
        "n",
        "<leader>m",
        ":silent !open -a Marked\\ 2.app '%:p'<CR>",
        { remap = true, silent = true, buffer = true, desc = "Open with Marked 2" }
      )
    end
  end,
})

-- Disable paste when leaving insert mode.
vim.api.nvim_create_augroup("disable_paste_on_leaving_insert_mode", { clear = true })
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  group = "disable_paste_on_leaving_insert_mode",
  pattern = { "*" },
  callback = function()
    if vim.opt.paste then
      vim.opt.paste = false
    end
  end,
})

-- Delete all trailing spaces
vim.api.nvim_create_augroup("delete_all_trailing_space", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = "delete_all_trailing_space",
  pattern = { "*" },
  command = [[%s/\s\+$//e]],
})

-- Create back-up files on save.
vim.api.nvim_create_augroup("create_backup_on_save", { clear = true })
vim.api.nvim_create_autocmd({ "BufWritePre", "FileWritePre", "FileAppendPre" }, {
  group = "create_backup_on_save",
  pattern = { "*" },
  callback = function()
    if vim.bo.filetype == "gitcommit" then
      return
    end

    local root_dir = vim.fn.stdpath("data") .. "/backup"
    local dest_dir = root_dir .. vim.fn.strftime("/%Y-%m-%d", vim.fn.localtime())

    if not vim.fn.isdirectory(dest_dir) then
      vim.fn.system({
        "mkdir",
        "-p",
        dest_dir,
      })
      vim.fn.system({
        "chown",
        "takeshi:staff",
        dest_dir,
      })
    end

    vim.opt.backupdir = dest_dir
    vim.opt.backupext = vim.fn.strftime(".%H%M", vim.fn.localtime())
  end,
})
