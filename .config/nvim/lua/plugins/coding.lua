return {
  { import = "lazyvim.plugins.extras.coding.yanky" },
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
