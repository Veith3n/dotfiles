-- stylua: ignore

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
-- Setup nvim-cmp.
-- local status_ok, spellsitter = pcall(require, "spellsitter")
-- if not status_ok then
  -- return
-- end

-- spellsitter.setup({
  -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
  -- enable = true,
-- })

return {
  -- -- Spellchecking
   -- {
   --   "lewis6991/spellsitter.nvim",
   --   -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
   --   setup = { enable = true },
   --  -- opts = {
   --   -- Whether enabled, can be a list of filetypes, e.g. {'python', 'lua'}
   --   -- enable = true,
   --   -- },
   -- },
   --
  -- Surround
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
}
