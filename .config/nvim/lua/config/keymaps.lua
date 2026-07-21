-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

-- Color scheme
keymap("n", "<A-S-l>", ":set background=light<CR>:colorscheme solarized<CR>", opts)
-- keymap("n", "<A-S-l>1", ":set background=light<CR>:colorscheme horizon<CR>", opts)
keymap("n", "<A-S-d>", ":set background=dark<CR>:colorscheme onedarker<CR>", opts)
-- keymap("n", "<A-S-d>", ":set background=dark<CR>:colorscheme horizon<CR>", opts)

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Yank to local clipboard in visual mode
keymap("v", "<leader>y", '"*y', opts)

-- Yank to local clipboard whole file in normal mode
vim.keymap.set("n", "<leader>yy", ":%y+<CR>")

-- Resize with arrows
keymap("n", "<A-Up>", ":resize +2<CR>", opts)
keymap("n", "<A-Down>", ":resize -2<CR>", opts)
keymap("n", "<A-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<A-Right>", ":vertical resize +2<CR>", opts)

-- Telescope
keymap("n", "<leader>p", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>f", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>r", "<cmd>Telescope resume<cr>", opts)
keymap("n", "<leader>ra", "<cmd>Telescope pickers<cr>", opts) -- return all cached pickers (searches)
