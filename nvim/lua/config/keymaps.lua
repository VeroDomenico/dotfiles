-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Copy to system clipboard (+)
vim.keymap.set("v", "<D-c>", '"+y', { desc = "Copy selection to clipboard" })
vim.keymap.set("n", "<D-c>", '"+yy', { desc = "Copy line to clipboard" }) -- Paste from system clipboard (+)

vim.keymap.set({ "n", "v" }, "<D-S-v>", '"+p', { desc = "Paste clipboard" })
vim.keymap.set("i", "<D-S-v>", "<D-r>+", { desc = "Paste clipboard in insert mode" })
