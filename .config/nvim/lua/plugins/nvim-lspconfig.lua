return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tailwindcss = {
        filetypes_include = {
          "rust",
        },
        init_options = {
          userLanguages = {
            rust = "html",
          },
        },
      },
    },
  },
}
