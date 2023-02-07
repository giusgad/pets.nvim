local M = {}
local Popup = require("nui.popup")

M.popup = Popup({
    position = {
        row = "100%",
        col = "100%",
    },
    size = {
        width = "25%",
        height = 10,
    },
    focusable = false,
    enter = false,
    win_options = {
        winblend = 100,
    },
})
return M
