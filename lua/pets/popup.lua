local M = {}
local Popup = require("nui.popup")
M.popup = Popup({
    position = {
        row = "100%", -- FIX: set row for different sizes / implement offset
        col = "100%",
    },
    relative = "editor",
    size = {
        width = 60,
        height = 10,
    },
    focusable = false,
    enter = false,
    win_options = {
        winblend = 100, -- TODO: set to 100 for transparent background
    },
})
return M
