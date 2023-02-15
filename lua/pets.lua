local M = {}
local utils = require("pets.utils")

M.options = {
    row = 1, -- the row (height) to display the pet at
    col = 0, -- the column to display the pet at (set to high numeber to have it stay stil at the right)
    speed_multiplier = 1,
    default_pet = "cat",
    default_style = "brown",
    random = true,
    death_animation = true,
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
function M.create_pet(name, type, style)
    if M.pets[name] ~= nil then
        utils.warning('Name "' .. name .. '" already in use')
        return
    end
    local pet = require("pets.pet").Pet.new(name, type, style, M.options)
    pet:animate()
    M.pets[pet.name] = pet
end

function M.kill_pet(name)
    if M.pets[name] ~= nil then
        M.pets[name]:kill()
        M.pets[name] = nil
    else
        utils.warning("Couldn't find a pet named \"" .. name .. '"')
    end
end

function M.kill_all()
    for _, pet in pairs(M.pets) do
        pet:kill()
    end
    M.pets = {}
end

function M.list()
    local empty = true
    for pet in pairs(M.pets) do
        print(pet)
        empty = false
    end
    if empty then
        print("You have no pets :(")
    end
end

function M.toggle_pause()
    for _, pet in pairs(M.pets) do
        pet:toggle_pause()
    end
end

function M.toggle_hide()
    for _, pet in pairs(M.pets) do
        pet:toggle_hide()
    end
end

return M
