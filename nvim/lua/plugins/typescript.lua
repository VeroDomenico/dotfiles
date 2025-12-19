return {
  -- Enable LazyVim's TypeScript/JavaScript stack (vtsls), Prettier, ESLint, and Tailwind defaults.
  {
    "LazyVim/LazyVim",
    opts = {
      extras = {
        "lazyvim.plugins.extras.lang.typescript",
        "lazyvim.plugins.extras.formatting.prettier",
        "lazyvim.plugins.extras.linting.eslint",
        "lazyvim.plugins.extras.lang.tailwind",
      },
    },
  },

  -- Add a convenient alias for source definitions (similar to Next.js jump-to-source)
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers = opts.servers or {}
      opts.servers.vtsls = opts.servers.vtsls or {}
      opts.servers.vtsls.keys = opts.servers.vtsls.keys or {}

      table.insert(opts.servers.vtsls.keys, {
        "gS",
        function()
          local win = vim.api.nvim_get_current_win()
          local params = vim.lsp.util.make_position_params(win, "utf-16")
          LazyVim.lsp.execute({
            command = "typescript.goToSourceDefinition",
            arguments = { params.textDocument.uri, params.position },
            open = true,
          })
        end,
        desc = "Goto Source Definition",
      })
    end,
  },
}
