return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      copilot = {
        keys = {
          {
            "<C-a>",
            function()
              vim.lsp.inline_completion.select({ count = 1 })
            end,
            desc = "Next Copilot Suggestion",
            mode = { "i", "n" },
          },
          {
            "<C-s>",
            function()
              vim.lsp.inline_completion.select({ count = -1 })
            end,
            desc = "Prev Copilot Suggestion",
            mode = { "i", "n" },
          },
        },
      },
    },
  },
}
