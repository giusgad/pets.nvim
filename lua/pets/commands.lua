local pets = require("pets")

vim.api.nvim_create_user_command("PetsNew", function(input)
    pets.create_pet(input.args, pets.options.default_pet, pets.options.default_style)
end, { nargs = 1 })

vim.api.nvim_create_user_command("PetsKillAll", function()
    pets.kill_all()
end, {})

vim.api.nvim_create_user_command("PetsKill", function(input)
    pets.kill_pet(input.args)
end, { nargs = 1 })

vim.api.nvim_create_user_command("PetsList", function()
    pets.list()
end, {})
