local M = {}

function M.setup(options)
    options = options or {}
    require("pets.setup")
end

function M.show()
    local popup = require("pets.popup").popup
    local utils = require("pets.utils")
    popup:mount()

    -- insert lines to avoid the image being stretched
    vim.api.nvim_buf_set_lines(popup.bufnr, 1, -1, false, { "", "", "", "", "", "", "", "", "", "", "" })
    popup.buf_options = { -- then set the buffer to be readonly
        modifiable = false,
        readonly = true,
    }

    utils.ShowPet(popup.bufnr)
end

return M
