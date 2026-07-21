return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
      "MunifTanjim/nui.nvim",
    },
    opts = {
      filesystem = {
        filtered_items = {
          visible = true, -- Show hidden files
          hide_dotfiles = false, -- Do not hide dotfiles (e.g., .config)
          hide_gitignored = false, -- Show files ignored by .gitignore
        },
      },
    },
  },
}
