
local function determine_color ()
  local dark_scheme = "onedarker"
  local light_scheme = "solarized"

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

local colorscheme = determine_color()

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
