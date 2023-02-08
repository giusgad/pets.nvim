local M = {}

M.options = {
    pet_name = "cat",
    pet_style = "brown",
    offset_rows = 0,
    offset_cols = 0,
}

M.pets = {}

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

    utils.ShowPet(popup.bufnr, M.options.offset_rows, M.options.offset_cols, M.options.pet_name, M.options.pet_style)
end

function M.create_pet(name, type, style)
    local pet = require("pets.pet").Pet.new(name, type, style)
    local popup = require("pets.popup").popup
    popup:mount()
    pet:animate(popup.bufnr)
    table.insert(M.pets, pet)
end

return M
