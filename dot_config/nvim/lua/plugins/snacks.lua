return {
  "folke/snacks.nvim",

  opts = {
    picker = {
      hidden = true,
      sources = {
        files = {
          hidden = true,
          ignored = true,
        },
      },
    },

    image = {
      enabled = true,
      force = true,
      doc = {
        enabled = true,
        inline = true,
        float = true,
      },
    },
  },

  config = function(_, opts)
    require("snacks").setup(opts)

    local terminal = require("snacks.image.terminal")

    terminal.size = function()
      local ui = vim.api.nvim_list_uis()[1]

      local columns = ui and ui.width or vim.o.columns
      local rows = ui and ui.height or vim.o.lines

      local cell_width = 11
      local cell_height = 25

      return {
        width = columns * cell_width,
        height = rows * cell_height,
        columns = columns,
        rows = rows,
        cell_width = cell_width,
        cell_height = cell_height,
        scale = math.max(1, cell_width / 8),
      }
    end
  end,
}
