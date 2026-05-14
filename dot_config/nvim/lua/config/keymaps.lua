-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set("i", "kj", "<ESC>")

-- Add relative line jumps to jumplist
vim.keymap.set({ "n", "x" }, "j", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "j" or "j"
end, { noremap = true, expr = true })

vim.keymap.set({ "n", "x" }, "k", function()
  return vim.v.count > 1 and "m'" .. vim.v.count .. "k" or "k"
end, { noremap = true, expr = true })
