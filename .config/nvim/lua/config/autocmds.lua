-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
--
-- vim.api.nvim_create_autocmd("BufWritePost", {
--   pattern = "en-custom.utf-8.add",
--   callback = function()
--     vim.cmd("mkspell! ~/.config/nvim/spell/en-custom.utf-8.add ~/.aspell.en.pws")
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("VimEnter", {
--   callback = function()
--     vim.loop.spawn("bash", { args = { "~/dotfiles/bin/generate_neovim_dict.sh" } }, function(code, signal)
--       -- Optional: handle exit or do nothing
--     end)
--   end,
-- })

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    vim.notify("Starting custom spell file generation...", vim.log.levels.INFO)
    vim.loop.spawn(
      "bash",
      { args = { vim.fn.expand("~/dotfiles/bin/generate_neovim_dict.sh") } },
      function(code, signal)
        local msg
        if code == 0 then
          msg = "Custom spell file generation completed successfully."
          vim.schedule(function()
            vim.notify(msg, vim.log.levels.INFO)
          end)
        else
          msg = "Custom spell file generation failed with exit code " .. tostring(code)
          vim.schedule(function()
            vim.notify(msg, vim.log.levels.ERROR)
          end)
        end
      end
    )
  end,
})
