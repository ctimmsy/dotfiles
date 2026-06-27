return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  cmd = {
    "ObsidianBacklinks",
    "ObsidianDailies",
    "ObsidianExtractNote",
    "ObsidianFollowLink",
    "ObsidianLink",
    "ObsidianLinkNew",
    "ObsidianLinks",
    "ObsidianNew",
    "ObsidianNewFromTemplate",
    "ObsidianOpen",
    "ObsidianPasteImg",
    "ObsidianQuickSwitch",
    "ObsidianRename",
    "ObsidianSearch",
    "ObsidianTags",
    "ObsidianTemplate",
    "ObsidianToday",
    "ObsidianToggleCheckbox",
    "ObsidianTomorrow",
    "ObsidianTOC",
    "ObsidianYesterday",
    "ObsidianMoveToZettelkasten", -- Add this
  },
  keys = {
    { "<leader>on", "<cmd>ObsidianNew<CR>", desc = "Obsidian New Note" },
    { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Obsidian backlinks" },
    { "<leader>od", "<cmd>ObsidianToday<CR>", desc = "Obsidian daily note" },
    { "<leader>ol", "<cmd>ObsidianLinks<CR>", desc = "Obsidian note links" },
    { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open in Obsidian" },
    { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian quick switch" },
    { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search Obsidian notes" },
    { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert Obsidian template" },
    { "<leader>oT", "<cmd>ObsidianTOC<CR>", desc = "Obsidian table of contents" },
    { "<leader>omz", "<cmd>ObsidianMoveToZettelkasten<CR>", desc = "Move note to zettelkasten" }, -- Add this
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    { "hrsh7th/nvim-cmp", enabled = true },
  },
  opts = {
    ui = {
      enable = false,
    },
    sort_by = "modified",
    workspaces = {
      {
        name = "personal",
        path = "~/obsidian/2nd Brain",
      },
    },
    completion = {
      -- Set to false to disable completion.
      nvim_cmp = true,
      -- Trigger completion at 2 chars.
      min_chars = 2,
    },
    notes_subdir = "01 Inbox",
    new_notes_location = "01 Inbox",
    note_id_func = function(title)
      if title ~= nil then
        -- Use the title exactly as-is for the ID
        return title
      else
        local suffix = ""
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
        return suffix
      end
    end,

    note_frontmatter_func = function(note)
      -- Explicit empty aliases - don't add the title as an alias
      local out = { id = note.id, aliases = {}, tags = note.tags }

      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,
    daily_notes = {
      folder = "02 Journal/01 Daily",
      date_format = "%Y-%m-%d",
      default_tags = { "daily-notes" },
      template = "Daily.md",
    },
    templates = {
      folder = "99 Resources/Templates",
      date_format = "%Y-%m-%d",
      time_format = "%H:%M",
      substitutions = {
        today = function()
          return os.date("%Y-%m-%d")
        end,
        yesterday = function()
          return os.date("%Y-%m-%d", os.time() - 86400)
        end,
        tomorrow = function()
          return os.date("%Y-%m-%d", os.time() + 86400)
        end,
      },
    },
    picker = {
      name = "telescope.nvim",
    },
  },
  config = function(_, opts)
    require("obsidian").setup(opts)

    -- Add custom move to zettelkasten command
    vim.api.nvim_create_user_command("ObsidianMoveToZettelkasten", function()
      local buf = vim.api.nvim_get_current_buf()
      local Note = require("obsidian.note")
      local Path = require("obsidian.path")

      local note = Note.from_buffer(buf)
      if not note.path then
        vim.notify("Current buffer is not a note", vim.log.levels.WARN)
        return
      end

      local client = require("obsidian").get_client()
      local vault_root = client:vault_root()
      local zettelkasten_folder = "05 Zettelkasten" -- Change to your folder name
      local target_dir = vault_root / zettelkasten_folder

      assert(target_dir):mkdir({ parents = true, exist_ok = true })

      -- Convert note.path to a Path object and get the filename
      local note_path = Path.new(note.path)
      local filename = note_path.name -- Use . not :
      local new_path = target_dir / filename

      local ok, err = os.rename(tostring(note.path), tostring(new_path))
      if ok then
        vim.cmd("edit " .. vim.fn.fnameescape(tostring(new_path)))
        vim.notify(string.format("Moved to %s", zettelkasten_folder), vim.log.levels.INFO)
      else
        vim.notify(string.format("Failed to move: %s", err), vim.log.levels.ERROR)
      end
    end, { nargs = 0, desc = "Move current note to zettelkasten folder" })
  end,
}
