return {
  { import = "lazyvim.plugins.extras.coding.yanky" },
  { import = "lazyvim.plugins.extras.coding.mini-surround" },
  {
    "gbprod/yanky.nvim",
    keys = {
      { "<leader>p", false },
      {
        "<leader>sy",
        function()
          require("telescope").extensions.yank_history.yank_history({})
        end,
        desc = "Yanked texts",
      },
    },
  },
}
