return {
  {
    "milanglacier/minuet-ai.nvim",
    config = function()
      require("minuet").setup({
        provider = "openai_fim_compatible",

        n_completions = 1,
        context_window = 512,
        request_timeout = 5,

        provider_options = {
          openai_fim_compatible = {
            api_key = "TERM",
            name = "Ollama",
            end_point = "http://localhost:11434/v1/completions",
            model = "qwen2.5-coder:7b",

            optional = {
              max_tokens = 128,
              top_p = 0.9,
            },
          },
        },

        virtualtext = {
          auto_trigger_ft = {
            "lua",
            "python",
            "javascript",
            "typescript",
            "rust",
            "go",
            "c",
            "cpp",
            "sh",
          },

          keymap = {
            accept = "<A-a>",
            accept_line = "<A-l>",
            accept_word = "<A-w>",
            next = "<A-]>",
            prev = "<A-[>",
            dismiss = "<A-e>",
          },
        },
      })
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("codecompanion").setup({
        adapters = {
          http = {
            ollama = function()
              return require("codecompanion.adapters").extend("ollama", {
                schema = {
                  model = {
                    default = "devstral-small-2",
                  },
                  num_ctx = {
                    default = 16384,
                  },
                  keep_alive = {
                    default = "30m",
                  },
                },
              })
            end,
          },
        },

        interactions = {
          chat = {
            adapter = "ollama",
          },
          inline = {
            adapter = "ollama",
          },
        },
      })
    end,
  },
}
