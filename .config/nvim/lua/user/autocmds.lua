vim.api.nvim_create_augroup('goodies', { clear = true })
-- Disable paste when leaving insert mode.
vim.api.nvim_create_autocmd({ 'InsertLeave' }, {
  group = 'goodies',
  pattern = { '*' },
  callback = function()
    if vim.opt.paste then
      vim.opt.paste = false
    end
  end,
})
-- Delete all trailing spaces
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  group = 'goodies',
  pattern = { '*' },
  command = [[%s/\s\+$//e]],
})
-- Create back-up files on save.
vim.api.nvim_create_autocmd({ 'BufWritePre', 'FileWritePre', 'FileAppendPre' }, {
  group = 'goodies',
  pattern = { '*' },
  callback = function()
    if vim.bo.filetype == 'gitcommit' then
      return
    end

    local root_dir = vim.fn.stdpath('data') .. '/backup'
    local dest_dir = root_dir .. vim.fn.strftime('/%Y-%m-%d', vim.fn.localtime())

    if not vim.fn.isdirectory(dest_dir) then
      vim.fn.system({
        'mkdir',
        '-p',
        dest_dir,
      })
      vim.fn.system({
        'chown',
        'takeshi:staff',
        dest_dir,
      })
    end

    vim.opt.backupdir = dest_dir
    vim.opt.backupext = vim.fn.strftime('.%H%M', vim.fn.localtime())
  end,
})
