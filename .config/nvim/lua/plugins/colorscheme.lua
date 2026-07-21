local dark_scheme = "onedarker"
local light_scheme = "solarized"
-- local light_scheme = "horizon"

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
  j:wait()

  local result = j:result()[1]
  -- print(type(result))
  -- print("Job Result raw:", result)
  local error_result = j:stderr_result()
  -- local theme = (result and #result > 0) and result or "Light"
  local theme = (result and #result > 0) and result

  if error_result and #error_result > 0 then
    theme = light_scheme -- Use a default theme if there's an error
  end

  -- print("Job Result: ", vim.inspect(theme))
  -- print("Job Error: ", vim.inspect(error_result))
  -- print("Return Value: ", return_val)
  if theme == "Dark" then
    -- Set dark colorscheme or perform other actions
    -- print("Setting dark colorscheme")
    return dark_scheme
  else
    -- Set light colorscheme or perform other actions
    -- print("Setting light colorscheme")
    return light_scheme
  end

  -- return "test"
  -- -- return if theme == "Dark" then dark_scheme else light_scheme end
  --
  -- if theme == "Dark" then
  --   return dark_scheme
  -- end
  --
  -- return light_scheme
end

function get_background_setting()
  local theme = determine_color_based_on_OS_setting()
  if theme == dark_scheme then
    return "dark"
  else
    return "light"
  end
end

local colorscheme = determine_color_on_fixed_hours()
-- local colorscheme = determine_color_based_on_OS_setting()

-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
local colorscheme = determine_color_based_on_OS_setting()
-- print("Color scheme based on fixed hours: " .. colorscheme)

-- local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
-- if not status_ok then
-- vim.notify("colorscheme " .. colorscheme .. " not found!")
-- return
-- end

return {
  -- Colorschemes
  { "joshdick/onedark.vim" },
  { "shaunsingh/solarized.nvim" },
  { "lunarvim/colorschemes" },
  -- { "akinsho/horizon.nvim" },
  { "LunarVim/horizon.nvim" },

  opts = {
    colorscheme = colorscheme,
    -- colorscheme = "solarized",
    -- colorscheme = "onedark",
  },

  -- vim.api.nvim_create_autocmd("User", {
  -- pattern = "LazyVimStarted",
  -- callback = function()
  -- vim.cmd.colorscheme("solarized")
  -- Set the background (optional)
  -- vim.o.background = "light" -- or "dark"
  -- end,
  -- })
  -- config = function()
  --   -- Load the colorscheme
  --   -- vim.cmd.colorscheme("horizon")
  --   vim.cmd.colorscheme(colorscheme)

  --   -- Set the background (optional)
  --   vim.o.background = "light" -- or "light"

  --   -- Highlight Overrides (Optional)
  --   -- Example:
  --   -- vim.api.nvim_create_autocommand('ColorScheme', {
  --   --   callback = function()
  --   --     vim.api.nvim_set_hl('CursorLine', { bg = '#1e1e1e', fg = '#ffffff', underline = true })
  --   --   end
  --   -- })
  -- end,

  -- config = function()
  --   print("Config function called")
  --   -- Set the colorscheme after plugins are loaded
  --   vim.api.nvim_create_autocmd("User", {
  --     pattern = "LazyVimStarted",
  --     callback = function()
  --       print("LazyVimStarted event triggered")
  --       vim.cmd.colorscheme(colorscheme)
  --       -- Set the background (optional)
  --       vim.o.background = "light" -- or "dark"
  --     end,
  --   })
  -- end,

  determine_color_on_fixed_hours = determine_color_on_fixed_hours,
  determine_color_based_on_OS_setting = determine_color_based_on_OS_setting,
  get_background_setting = get_background_setting,
}
-- if not status_ok then
-- vim.notify("colorscheme " .. colorscheme .. " not found!")
-- return
-- end
