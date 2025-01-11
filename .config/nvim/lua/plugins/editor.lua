return {
  {
    "folke/flash.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, false },
      { "S", false },
      { "r", false },
      { "R", false },
      {
        "<leader>ls",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
      {
        "<leader>lS",
        mode = { "n", "o", "x" },
        function()
          require("flash").treesitter()
        end,
        desc = "Flash Treesitter",
      },
      {
        "<leader>lr",
        mode = "o",
        function()
          require("flash").remote()
        end,
        desc = "Remote Flash",
      },
      {
        "<leader>lR",
        mode = { "o", "x" },
        function()
          require("flash").treesitter_search()
        end,
        desc = "Treesitter Search",
      },
      {
        "<leader>lt",
        mode = { "n" },
        function()
          require("flash").toggle()
        end,
        desc = "Toggle Flash Search",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts_extend = { "spec" },
    opts = {
      spec = {
        { "<leader>l", group = "flash", icon = { icon = "", color = "yellow" } },
        { "s", group = "surround" },
      },
    },
  },
  {
    "ibhagwan/fzf-lua",
    keys = {
      { "<leader>,", false },
      { "<leader>/", false },
      { "<leader>:", false },
      { "<leader><space>", false },
      { "<leader>fb", false },
      { "<leader>fc", false },
      { "<leader>ff", false },
      { "<leader>fF", false },
      { "<leader>fg", false },
      { "<leader>fr", false },
      { "<leader>fR", false },
      { "<leader>sH", false },
      { "<leader>sb", "<cmd>FzfLua buffers sort_mru=true sort_lastused=true<cr>", desc = "Buffers" },
      { "<leader>sc", LazyVim.pick.config_files(), desc = "Config Files" },
      { "<leader>sf", LazyVim.pick("files"), desc = "Files (Root Dir)" },
      { "<leader>sF", LazyVim.pick("files", { root = false }), desc = "Files (cwd)" },
      { "<leader>sg", "<cmd>FzfLua git_files<cr>", desc = "Files (Git)" },
      { "<leader>so", "<cmd>FzfLua oldfiles<cr>", desc = "Recent Files " },
      { "<leader>sO", LazyVim.pick("oldfiles", { cwd = vim.uv.cwd() }), desc = "Recent Files (cwd)" },
      { "<leader>sg", LazyVim.pick("live_grep"), desc = "Grep (Root Dir)" },
      { "<leader>sG", LazyVim.pick("live_grep", { root = false }), desc = "Grep (cwd)" },
      { "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "Help Pages" },
      { "<leader>sm", "<cmd>FzfLua marks<cr>", desc = "Marks" },
      { "<leader>sR", "<cmd>FzfLua resume<cr>", desc = "Resume" },
      { "<leader>sw", LazyVim.pick("grep_cword"), desc = "Word (Root Dir)" },
      { "<leader>sW", LazyVim.pick("grep_cword", { root = false }), desc = "Word (cwd)" },
      { "<leader>sw", LazyVim.pick("grep_visual"), mode = "v", desc = "Selection (Root Dir)" },
      { "<leader>sW", LazyVim.pick("grep_visual", { root = false }), mode = "v", desc = "Selection (cwd)" },
    },
  },
}
