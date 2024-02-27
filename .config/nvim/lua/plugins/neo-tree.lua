return {
  "nvim-neo-tree/neo-tree.nvim",

  opts = {
    window = {
      mappings = {
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
    event_handlers = {
      {
        event = "file_opened",
        handler = function()
          require("neo-tree.command").execute({ action = "close" })
        end,
      },
    },
  },
}
