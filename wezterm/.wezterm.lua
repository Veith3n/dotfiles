local wezterm = require "wezterm"

local config = {}

local launch_menu = {}
config.launch_menu = launch_menu

-- local ssh_cmd = {"ssh"}
-- Define the light and dark color schemes
local light_scheme = "Builtin Solarized Light"
local dark_scheme = "Builtin Solarized Dark"

config.enable_csi_u_key_encoding = true
config.use_ime = true

-- Function to set the color scheme based on the key pressed
local function set_color_scheme(window, scheme)
	local overrides = window:get_config_overrides() or {}
	overrides.color_scheme = scheme
	window:set_config_overrides(overrides)
end

-- Key bindings for switching between light and dark themes
wezterm.on("set-light-theme", function(window, pane)
	set_color_scheme(window, light_scheme)
end)

wezterm.on("set-dark-theme", function(window, pane)
	set_color_scheme(window, dark_scheme)
end)

	-- Automatically set the color scheme based on appearance
	config.color_scheme = wezterm.gui.get_appearance():find("Dark") and dark_scheme or light_scheme
	-- config.color_scheme = light_scheme

-- if wezterm.target_triple == "x86_64-pc-windows-msvc" then
--     ssh_cmd = {"powershell.exe", "ssh"}
--
--     table.insert(
--         launch_menu,
--         {
--             label = "Bash",
--             args = {"C:/Program Files/Git/bin/bash.exe", "-li"}
--         }
--     )
--
-- --     table.insert(
-- --         launch_menu,
-- --         {
-- --             label = "CMD",
-- --             args = {"cmd.exe"}
-- --         }
-- --     )
--
--     table.insert(
--         launch_menu,
--         {
--             label = "PowerShell",
--             args = {"powershell.exe", "-NoLogo"}
--         }
--     )
--
-- end
--
-- -- Set Bash as the default program
-- config.default_prog = { "C:/Program Files/Git/bin/bash.exe", "--login" }
--
-- wezterm.plugin
--   .require('https://github.com/yriveiro/wezterm-status')
--   .apply_to_config(config, {
--     cells = {
--       git_status = { enabled = false },
--     }
--   })
--
-- local ssh_config_file = wezterm.home_dir .. "/.ssh/config"
-- local f = io.open(ssh_config_file)
-- if f then
--     local line = f:read("*l")
--     while line do
--         if line:find("Host ") == 1 then
--             local host = line:gsub("Host ", "")
--             local args = {}
--             for i,v in pairs(ssh_cmd) do
--                 args[i] = v
--             end
--             args[#args+1] = host
--             table.insert(
--                 launch_menu,
--                 {
--                     label = "SSH " .. host,
--                     args = args,
--                 }
--             )
--             -- default open vm
--             if host == "vm" then
--                 config.default_prog = {"powershell.exe", "ssh", "vm"}
--             end
--         end
--         line = f:read("*l")
--     end
--     f:close()
-- end

config.mouse_bindings = {
    -- 右键粘贴
    {
        event = {Down = {streak = 1, button = "Right"}},
        mods = "NONE",
        action = wezterm.action {PasteFrom = "Clipboard"}
    },
    -- Change the default click behavior so that it only selects
    -- text and doesn't open hyperlinks
    {
        event = {Up = {streak = 1, button = "Left"}},
        mods = "NONE",
        action = wezterm.action {CompleteSelection = "PrimarySelection"}

    },
    -- and make CTRL-Click open hyperlinks
    {
        event = {Up = {streak = 1, button = "Left"}},
        mods = "CTRL",
        action = "OpenLinkAtMouseCursor"
    },

-- Update mouse bindings for automatic copy on selection
  {
    event = { Up = { streak = 1, button = 'Left' } },
    mods = 'NONE',
    action = wezterm.action.CompleteSelection('Clipboard'),
  },
}

-- Add key bindings
config.keys = {
    -- Bind Ctrl+V to paste from clipboard
    { key = "v", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },

    -- Bind Ctrl+T to open a new tab
    { key = "t", mods = "CTRL", action = wezterm.action.SpawnTab("CurrentPaneDomain") },

    -- Bind Ctrl+W to close the current tab
    { key = "w", mods = "CTRL", action = wezterm.action.CloseCurrentPane { confirm = false } },

    -- Ctrl+Shift+{ to move to the tab on the left
    { key = "{", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },

    -- Ctrl+Shift+} to move to the tab on the right
    { key = "}", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
    
    -- Ctrl+Shift+] to move to the tab on the right
    { key = "Enter", mods = "CTRL", action = wezterm.action.SplitPane{direction = "Right", size = { Percent = 50 }} },

    -- clears tab
		{ key = "k", mods = "CTRL", action = wezterm.action.ClearScrollback("ScrollbackAndViewport") },

		{ key = "l", mods = "CTRL", action = wezterm.action.EmitEvent("set-light-theme") },
		{ key = "d", mods = "CTRL", action = wezterm.action.EmitEvent("set-dark-theme") },
		{ key = "t", mods = "CTRL|SHIFT", action = wezterm.action.EmitEvent("toggle-theme") },
}

local wezterm = require 'wezterm'

-- -- clear current tab and its history
-- config.keys = {
--     {
--         key = 'K',
--         mods = 'CTRL|SHIFT',
--         action = wezterm.action_callback(function(window, pane)
--             -- Scroll to the bottom if not already there
--             window:perform_action(wezterm.action.ScrollToBottom, pane)
--
--             -- Get the current height of the viewport
--             local height = pane:get_dimensions().viewport_rows
--
--             -- Build a string of new lines equal to the viewport height
--             local blank_viewport = string.rep('\r\n', height)
--
--             -- Inject those new lines to push the viewport contents into the scrollback
--             pane:inject_output(blank_viewport)
--
--             -- Send an escape sequence to clear the viewport (CTRL-L)
--             pane:send_text('\x0c')
--
--             -- Print the current directory
--             -- pane:send_text('pwd\n')
--         end),
--     },
-- }
--



-- Bind Ctrl+1 to switch to the first tab
-- Bind Ctrl+2 to switch to the second tab, and so on
for i = 1, 9 do
    table.insert(config.keys, {
            key = tostring(i),
            mods = "CTRL",
            action = wezterm.action.ActivateTab(i - 1), -- Tabs are 0-indexed
        })
end


 wezterm.on('format-tab-title', function (tab, _, _, _, _)
     return {
        { Text = ' ' .. tab.tab_index + 1 .. ' ' },
    }
end)

wezterm.on("gui-startup", function()
  local tab, pane, window = wezterm.mux.spawn_window{}
  window:gui_window():maximize()
end)

local window_min = ' 󰖰 '
local window_max = ' 󰖯 '
local window_close = ' 󰅖 '
config.tab_bar_style = {
    window_hide = window_min,
    window_hide_hover = window_min,
    window_maximize = window_max,
    window_maximize_hover = window_max,
    window_close = window_close,
    window_close_hover = window_close,
}

config.use_fancy_tab_bar = false
-- config.use_fancy_tab_bar = true
config.window_decorations="INTEGRATED_BUTTONS|RESIZE"
config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
-- config.color_scheme = 'Catppuccin Frappe'
config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}
config.check_for_updates = false


-- Function to perform git fetch
local function git_fetch()
	local success, stdout, stderr = wezterm.run_child_process({ "git", "fetch" })
	if success then
		wezterm.log_info("Git fetch successful")
	else
		wezterm.log_error("Git fetch failed: " .. stderr)
	end
end

-- -- Set up a timer to run git fetch periodically
-- wezterm.on("gui-startup", function()
-- 	local timer = wezterm.timer.new({
-- 		interval = 2, -- Run every 60 seconds
-- 		callback = function()
-- 			-- Check if we're in a git repository
-- 			local success, _, _ = wezterm.run_child_process({ "git", "rev-parse", "--is-inside-work-tree" })
-- 			if success then
-- 				git_fetch()
-- 			end
-- 		end,
-- 	})
-- 	timer:start()
-- end)


-- Function to get git status
local function get_git_status()
	local success, stdout, stderr = wezterm.run_child_process({ "git", "status", "--porcelain", "--branch" })
  print('succ')
	-- local success, stdout, stderr = wezterm.run_child_process({"pwd"})
  print('success', success)
  print('stdout', stdout)
  print('stderr', stderr)
	if not success then
		-- return "assa"+stdout
    return "xfasfas"
		-- return stderr
	end

	local ahead = stdout:match("ahead (%d+)")
	local behind = stdout:match("behind (%d+)")
	local status = ""
  status = "assa"
  -- status = success .. "assa"
  return status
  --
	-- if ahead then
	-- 	status = status .. "↑" .. ahead
	-- end
	-- if behind then
	-- 	status = status .. "↓" .. behind
	-- end
  --
	-- return status
end

-- -- Set up the status update
-- wezterm.on("update-status", function(window, pane)
-- 	local git_status = get_git_status()
-- 	window:set_right_status(wezterm.format({
-- 		{ Text = git_status },
-- 	}))
-- end)


wezterm.on("update-right-status", function(window, pane)
    local date = wezterm.strftime("%Y-%m-%d %H:%M:%S   ")
  --  local cwd_uri = pane:get_current_working_dir()
    local cmd = ""
  --  if cwd_uri
 --       print(cwd_uri)
     -- cmd = cwd_uri.sub(8)
--else
     cmd = 'dsa'
--end
	local git_status = get_git_status()
    window:set_right_status(
        wezterm.format(
            {
                {Text = cmd .. git_status .. " " .. date}
            }
        )
    )
end)

return config

