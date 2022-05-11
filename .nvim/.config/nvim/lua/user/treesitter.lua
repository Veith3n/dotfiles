local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false,  -- install languages synchronously (only applied to `ensure_installed`)
  ignore_install = { "phpdoc" }, -- https://github.com/filipekiss/nvim.lua/commit/eac8dfd8d393985e877d8b5dd1ad2d329a64ce60#diff-c184ac514122483c3cc73182b1a7c5d94ab7df2408f19f974c85454ebf498c58
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { "" }, -- list of language that will be disabled
    additional_vim_regex_highlighting = true,
  },
  indent = { enable = true, disable = { "yaml" } },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  },
  autopairs = { enable = true },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
}
