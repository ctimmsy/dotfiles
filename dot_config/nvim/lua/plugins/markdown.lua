return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    opts = {
      code = {
        sign = true,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = true,
        icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      },
      checkbox = {
        enabled = true,
      },
    },
  },
  {
    {
      "mfussenegger/nvim-lint",
      optional = true,
      opts = {
        linters_by_ft = {
          markdown = false,
        },
      },
    },
  },
}
