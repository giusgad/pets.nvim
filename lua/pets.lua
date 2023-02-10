local M = {}

M.options = {
    row = 1,
    col = 0,
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

-- create a Pet object and add it to the pets table
function M.create_pet(name, type, style) -- TODO: don't allow duplicate names
    local pet = require("pets.pet").Pet.new(name, type, style, M.options.row, M.options.col)
    pet:animate()
    table.insert(M.pets, pet)
end

-- function M.kill_pet(name) end

function M.kill_all()
    for _, pet in pairs(M.pets) do
        pet:kill()
    end
end

function M.list()
    for _, pet in pairs(M.pets) do
        print(pet.name)
    end
end

return M
