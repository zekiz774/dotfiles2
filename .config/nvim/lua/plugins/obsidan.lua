return {
  "epwalsh/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  event = {
    -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
    -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
    "BufReadPre /home/deck/Documents/Obsidian-Vault/",
    "BufNewFile /home/deck/Documents/Obsidian-Vault/",
  },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "nvim-treesitter/nvim-treesitter",

    -- see below for full list of optional dependencies 👇
  },
  opts = {
    workspaces = {
      {
        name = "Obsidian-Vault",
        path = "/home/deck/Documents/Obsidian-Vault",
      },
    },

    notes_subdir = "notes",
    new_notes_location = "notes_subdir",

    daily_notes = {
      folder = "notes/daily",
      template = "daily-template.md",
    },

    templates = {
      subdir = "templates",
    },

    -- Optional, customize how names/IDs for new notes are created.
    note_id_func = function(title)
      -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
      -- In this case a note with the title 'My new note' will be given an ID that looks
      -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
      local suffix = ""
      if title ~= nil then
        -- If title is given, transform it into valid file name.
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", "")
      else
        -- If title is nil, just add 4 random uppercase letters to the suffix.
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(suffix)
    end,

    -- Optional, alternatively you can customize the frontmatter data.
    ---@return table
    note_frontmatter_func = function(note)
      -- Add the title of the note as an alias.
      if note.title then
        note:add_alias(note.title)
      end

      local out = { aliases = note.aliases, tags = note.tags }

      -- `note.metadata` contains any manually added fields in the frontmatter.
      -- So here we just make sure those fields are kept in the frontmatter.
      if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
        for k, v in pairs(note.metadata) do
          out[k] = v
        end
      end

      return out
    end,

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.

      ["gf"] = {
        action = function()
          return require("obsidian").util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ["<leader>ch"] = {
        action = function()
          return require("obsidian").util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },

      -- Searches your Vault using ObsidianSearch.
      ["<leader><space>"] = {
        action = function()
          return vim.cmd("ObsidianSearch")
        end,
        opts = { noremap = true, silent = true },
      },

      -- Open the daily note for today.
      ["<leader>fd"] = {
        action = function()
          return vim.cmd("ObsidianToday")
        end,
        opts = { noremap = true, silent = true },
      },

      -- Creates a new note
      ["<leader>fn"] = {
        action = function()
          return vim.cmd("ObsidianNew")
        end,
        opts = { noremap = true, silent = true },
      },
    },
  },
}
