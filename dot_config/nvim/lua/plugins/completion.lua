return {
  -- disable mini.completion
  {
    "nvim-mini/mini.completion",
    enabled = false,
  },

  -- enable nvim-cmp
  { import = "lazyvim.plugins.extras.coding.nvim-cmp" },
}
