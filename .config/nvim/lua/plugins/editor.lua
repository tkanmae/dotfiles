local Util = require("lazyvim.util")

-- TODO: Figure out a way to search todo comments in a workspace.

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = function()
      return {
        { "<leader>sb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>sc", Util.telescope.config_files(), desc = "NeoVim config files" },
        { "<leader>sf", Util.telescope("files"), desc = "Files (root dir)" },
        { "<leader>sF", Util.telescope("files", { cwd = false }), desc = "Files (cwd)" },
        { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recently opened files" },
        { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        { "<leader>sg", Util.telescope("live_grep"), desc = "Grep (root dir)" },
        { "<leader>sG", Util.telescope("live_grep", { cwd = false }), desc = "Grep (cwd)" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help pages" },
        { "<leader>sw", Util.telescope("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
        { "<leader>sW", Util.telescope("grep_string", { cwd = false, word_match = "-w" }), desc = "Word (cwd)" },
        { "<leader>sw", Util.telescope("grep_string"), mode = "v", desc = "Selection (root dir)" },
        { "<leader>sW", Util.telescope("grep_string", { cwd = false }), mode = "v", desc = "Selection (cwd)" },
        { "<leader>sk", "<cmd>Telescope keymaps<cr>", desc = "Key maps" },
        {
          "<leader>ss",
          function()
            require("telescope.builtin").lsp_document_symbols({
              symbols = require("lazyvim.config").get_kind_filter(),
            })
          end,
          desc = "Symbol",
        },
        {
          "<leader>sS",
          function()
            require("telescope.builtin").lsp_dynamic_workspace_symbols({
              symbols = require("lazyvim.config").get_kind_filter(),
            })
          end,
          desc = "Symbol (Workspace)",
        },
      }
    end,
    opts = {
      pickers = {
        buffers = {
          mappings = {
            n = {
              ["d"] = function(...)
                require("telescope.actions").delete_buffer(...)
              end,
            },
          },
        },
      },
    },
  },
  {
    "nvim-pack/nvim-spectre",
    keys = {
      { "<leader>sr", false },
    },
  },
}
