local M = {}

M.stack = {
    popups = {},
    images = {},
    jobs = {},
}

M.options = {
    pet_name = "cat",
    pet_style = "brown",
    fps = 8,
    offset_rows = 0,
    offset_cols = 0,
}

function M.setup(options)
    options = options or {}
    M.options = vim.tbl_deep_extend("force", M.options, options)

    -- init hologram
    local ok = pcall(require, "hologram")
    if ok then
        require("hologram").setup({ auto_display = false })
    end

    require("pets.commands") -- init autocommands
end

--[[ This function creates the popup for the image to be displayed and
takes care of calling the utils.ShowPet function.]]
function M.show()
    local popup = require("pets.popup").popup
    local utils = require("pets.utils")
    popup:mount()

    popup.buf_options = { -- then set the buffer to be readonly
        modifiable = false,
        readonly = true,
    }

    local image = utils.ShowPet(
        popup.bufnr,
        M.options.offset_rows,
        M.options.offset_cols,
        M.options.pet_name,
        M.options.pet_style,
        M.options.fps
    )
    table.insert(M.stack.popups, popup) -- TODO: update for multiple images
    table.insert(M.stack.images, image)
end

-- close all the popups and stop displaying any image
function M.closeAll() -- TODO: update for multiple images
    for _, image in pairs(M.stack.images) do
        image:delete(0, {
            free = false,
        })
    end
    for _, popup in pairs(M.stack.popups) do
        popup:unmount()
    end
end

return M
