-- ~/.config/nvim/lua/plugins/lang_go.lua
return {
  -- This ensures the base Go extra is loaded and allows you to override its settings
  {
    "LazyVim/LazyVim",
    opts = {
      extras = {
        "lang.go",
      },
    },
  },
  -- Override/extend nvim-lspconfig settings for gopls
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          -- Your custom gopls settings here.
          -- These will be merged with LazyVim's defaults.
          settings = {
            gopls = {
              -- Example: Disable gc_details codelenses if you find them noisy
              codelenses = {
                gc_details = false,
                test = true, -- Keep run test codelenses
                generate = true,
              },
              -- Example: Add custom build flags if needed
              -- buildFlags = { "-tags=integration" },
              -- Example: Ensure gofumpt is explicitly true (LazyVim enables it by default)
              gofumpt = true,
              -- Example: Enable/disable staticcheck (usually true by default)
              -- staticcheck = true,
            },
          },
          -- You can also add custom capabilities or on_attach functions here
          -- on_attach = function(client, bufnr)
          --   -- Custom actions when gopls attaches
          --   -- For example, setting up format on save if LazyVim doesn't do it as you like
          -- end,
        },
      },
    },
  },
}
