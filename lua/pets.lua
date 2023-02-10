local M = {}

M.options = {
    pet_type = "cat",
    pet_style = "brown",
    offset_rows = 0,
    offset_cols = 0,
}

M.stack = { pets = {}, popups = {} }

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

-- create a Pet object and add it to the pets table
function M.create_pet(name, type, style)
    local pet = require("pets.pet").Pet.new(name, type, style)
    local popup = require("pets.popup").popup
    popup:mount()
    pet:animate(popup.bufnr)
    table.insert(M.stack.pets, pet)
    table.insert(M.stack.popups, popup)
end

-- function M.kill_pet(name) end

function M.kill_all()
    for _, pet in pairs(M.stack.pets) do
        pet:kill()
    end
    for _, popup in pairs(M.stack.popups) do
        popup:unmount()
    end
end

return M
