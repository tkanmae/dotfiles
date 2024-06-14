-- TODO: Figure out a way to search todo comments in a workspace.

return {
  {
    "nvim-telescope/telescope.nvim",
    keys = function()
      return {
        { "<leader>sb", "<cmd>Telescope buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
        { "<leader>sc", LazyVim.pick.config_files(), desc = "NeoVim config files" },
        { "<leader>sf", LazyVim.pick("auto"), desc = "Files (root dir)" },
        { "<leader>sF", LazyVim.pick("auto", { root = false }), desc = "Files (cwd)" },
        { "<leader>sr", "<cmd>Telescope oldfiles<cr>", desc = "Recently opened files" },
        { "<leader>sR", "<cmd>Telescope resume<cr>", desc = "Resume" },
        { "<leader>sd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
        { "<leader>sD", "<cmd>Telescope diagnostics<cr>", desc = "Workspace diagnostics" },
        { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (root dir)" },
        { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
        { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "Help pages" },
        { "<leader>sw", LazyVim.pick("grep_string", { word_match = "-w" }), desc = "Word (root dir)" },
        { "<leader>sW", LazyVim.pick("grep_string", { root = false, word_match = "-w" }), desc = "Word (cwd)" },
        { "<leader>sw", LazyVim.pick("grep_string"), mode = "v", desc = "Selection (root dir)" },
        { "<leader>sW", LazyVim.pick("grep_string", { root = false }), mode = "v", desc = "Selection (cwd)" },
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
