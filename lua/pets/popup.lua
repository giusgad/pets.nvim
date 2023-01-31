local M = {}
local Popup = require("nui.popup")
M.popup = Popup({
  position = {
    row = "100%", -- FIX: set row for different sizes / implement offset
    col = "100%",
  },
  relative = "editor",
  size = {
    width = "25%",
    height = 10,
  },
  focusable = false,
  enter = false,
  win_options = {
    winblend = 10,
  },
})
return M
