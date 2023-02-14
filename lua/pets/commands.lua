local pets = require("pets")
local wd = debug.getinfo(1).source:sub(2):match("(.*nvim/)") .. "media/"
local available_pets = {}
for _, pet in pairs(require("pets.utils").listdir(wd)) do
    local styles = require("pets.utils").listdir(wd .. pet)
    available_pets[pet] = styles
end

vim.api.nvim_create_user_command("PetsNew", function(input)
    --TODO: validate style and type options
    local pet, style = pets.options.default_pet, pets.options.default_style
    if pets.options.random then
        local styles = available_pets["cat"]
        pet, style = "cat", styles[math.random(#styles)]
    end
    pets.create_pet(input.args, pet, style)
end, { nargs = 1 })

local function autocomplete_petsnew(_, cmdline)
    local matches = {}
    local words = vim.split(cmdline, " ", { trimempty = true })

    if not vim.endswith(cmdline, " ") then
        table.remove(words, #words)
    end

    if #words == 1 then
        for _, v in available_pets do
            table.insert(matches, v)
        end
    elseif #words == 2 then
        local styles = available_pets[words[2]]
        for _, v in pairs(styles) do
            table.insert(matches, v)
        end
    end
    return matches
end

vim.api.nvim_create_user_command("PetsNewCustom", function(input)
    local args = vim.split(input.args, " ", { trimempty = true })
    if #args ~= 3 then
        local msg = "Inccorect number of arguments!\nUSAGE: PetsNewCustom {type} {style} {name}"
        vim.notify(msg, vim.log.levels.WARN)
        return
    end
    local type, style, name = args[1], args[2], args[3]
    pets.create_pet(name, type, style)
end, { nargs = 1, complete = autocomplete_petsnew })

vim.api.nvim_create_user_command("PetsKillAll", function()
    pets.kill_all()
end, {})

vim.api.nvim_create_user_command("PetsKill", function(input)
    pets.kill_pet(input.args)
end, {
    nargs = 1,
    complete = function()
        local matches = {}
        for k, _ in pairs(pets.pets) do
            table.insert(matches, k)
        end
        return matches
    end,
})

vim.api.nvim_create_user_command("PetsList", function()
    pets.list()
end, {})
