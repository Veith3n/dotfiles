-- following options are default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
-- vim.g.nvim_tree_icons = {
--   default = "",
--   symlink = "",
--   git = {
--     unstaged = "",
--     staged = "S",
--     unmerged = "",
--     renamed = "➜",
--     deleted = "",
--     untracked = "U",
--     ignored = "◌",
--   },
--   folder = {
--     default = "",
--     open = "",
--     empty = "",
--     empty_open = "",
--     symlink = "",
--   },
--   -- indicator = { style = "icon", icon = "▎" },
-- }

local status_ok, nvim_tree = pcall(require, "nvim-tree")
if not status_ok then
	return
end

local config_status_ok, nvim_tree_config = pcall(require, "nvim-tree.config")
if not config_status_ok then
	return
end

local tree_cb = nvim_tree_config.nvim_tree_callback

nvim_tree.setup({
	renderer = {
		icons = {
			glyphs = {
				default = "",
				symlink = "",
				git = {
					unstaged = "",
					staged = "S",
					unmerged = "",
					renamed = "➜",
					deleted = "",
					untracked = "U",
					ignored = "◌",
				},
				folder = {
					default = "",
					open = "",
					empty = "",
					empty_open = "",
					symlink = "",
				},
			},
		},
	},

	-- disable_netrw = true,
	disable_netrw = false,
	-- hijack_netrw = false,
	hijack_netrw = true,
	--[[ open_on_setup = true, DEPRECATED]]
	--[[ ignore_ft_on_setup = { "startify", "dashboard", "alpha" }, DEPRECATED]]
	--[[ open_on_tab = false, ]]
	hijack_cursor = false,
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	hijack_unnamed_buffer_when_opening = false,
	update_cwd = true,
	-- update_to_buf_dir = {
	--   enable = true,
	--   auto_open = true,
	-- },
	diagnostics = {
		enable = true,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	update_focused_file = {
		enable = true,
		update_cwd = true,
		ignore_list = {},
	},
	system_open = {
		cmd = nil,
		args = {},
	},
	filters = {
		dotfiles = false,
		custom = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 200,
	},
	view = {
		width = 30,
		adaptive_size = true,
		-- height = 30,
		hide_root_folder = false,
		side = "left",
		-- auto_resize = true,
		mappings = {
			custom_only = false,
			list = {
				{
					key = { "l", "<CR>", "o" },
					cb = tree_cb("edit"),
				},
				{
					key = "h",
					cb = tree_cb("close_node"),
				},
				{
					key = "v",
					cb = tree_cb("vsplit"),
				},
				{
					key = "B",
					cb = tree_cb("split"),
				}, -- defaults below
				{
					key = { "<CR>", "o", "<2-LeftMouse>" },
					action = "edit",
				},
				{
					key = "<C-e>",
					action = "edit_in_place",
				},
				{
					key = { "O" },
					action = "edit_no_picker",
				},
				{
					key = { "<2-RightMouse>", "<C-]>" },
					action = "cd",
				},
				{
					key = "<C-v>",
					action = "vsplit",
				},
				{
					key = "<C-x>",
					action = "split",
				},
				{
					key = "<C-t>",
					action = "tabnew",
				},
				{
					key = "<",
					action = "prev_sibling",
				},
				{
					key = ">",
					action = "next_sibling",
				},
				{
					key = "P",
					action = "parent_node",
				},
				{
					key = "<BS>",
					action = "close_node",
				},
				{
					key = "<Tab>",
					action = "preview",
				},
				{
					key = "K",
					action = "first_sibling",
				},
				{
					key = "J",
					action = "last_sibling",
				},
				{
					key = "I",
					action = "toggle_ignored",
				},
				{
					key = "H",
					action = "toggle_dotfiles",
				},
				{
					key = "R",
					action = "refresh",
				},
				{
					key = "a",
					action = "create",
				},
				{
					key = "d",
					action = "remove",
				},
				{
					key = "D",
					action = "trash",
				},
				{
					key = "r",
					action = "rename",
				},
				{
					key = "<C-r>",
					action = "full_rename",
				},
				{
					key = "x",
					action = "cut",
				},
				{
					key = "c",
					action = "copy",
				},
				{
					key = "p",
					action = "paste",
				},
				{
					key = "y",
					action = "copy_name",
				},
				{
					key = "Y",
					action = "copy_path",
				},
				{
					key = "gy",
					action = "copy_absolute_path",
				},
				{
					key = "[c",
					action = "prev_git_item",
				},
				{
					key = "]c",
					action = "next_git_item",
				},
				{
					key = "-",
					action = "dir_up",
				},
				{
					key = "s",
					action = "system_open",
				},
				{
					key = "q",
					action = "close",
				},
				{
					key = "g?",
					action = "toggle_help",
				},
				{
					key = "W",
					action = "collapse_all",
				},
				{
					key = "S",
					action = "search_node",
				},
				{
					key = "<C-k>",
					action = "toggle_file_info",
				},
				{
					key = ".",
					action = "run_file_command",
				},
			},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	actions = {
		open_file = {
			quit_on_open = false,
			window_picker = {
				enable = false,
			},
		},
	},
	-- git_hl = 1,
	-- root_folder_modifier = ":~",  -- This is the default. See :help filename-modifiers for more options
	-- auto_close = false,
	-- show_icons = {
	--   git = 1,
	--   folders = 1,
	--   files = 1,
	--   folder_arrows = 1,
	--   tree_width = 30,
	-- },
})
