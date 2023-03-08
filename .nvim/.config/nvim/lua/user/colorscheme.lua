local dark_scheme = "onedarker"
local light_scheme = "solarized"

local function determine_color_on_fixed_hours()
	local light_scheme_start_time = 6
	local light_scheme_end_time = 20

	local current_hour = tonumber(os.date("%H"))

	if current_hour > light_scheme_start_time then
		if current_hour < light_scheme_end_time then
			return light_scheme
		else
			return dark_scheme
		end
	else
		return dark_scheme
	end
end

function determine_color_based_on_OS_setting() -- works only for Macos
	local Job = require("plenary.job")

	local j = Job:new({ command = "defaults", args = { "read", "-g", "AppleInterfaceStyle" } })

	j:start()

	local theme = j:result()[1]

	-- return "test"
	-- return if theme == "Dark" then dark_scheme else light_scheme end

	if theme == "Dark" then
		return dark_scheme
	end

	return light_scheme
end

-- local colorscheme = determine_color_based_on_OS_setting()
local colorscheme = determine_color_on_fixed_hours()

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
-- vim.notify("colorscheme " .. colorscheme .. " not found!")
-- return
-- end
