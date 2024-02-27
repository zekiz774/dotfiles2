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

    daily_notes = {
      folder = "notes/daily",
      template = "daily-template",
    },

    templates = {
      subdir = "templates",
    },
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
    },
  },
}
