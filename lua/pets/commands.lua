local pets = require("pets")

vim.api.nvim_create_user_command("PetsNew", function(input)
    pets.create_pet(input.args, "cat", "light_grey")
end, { nargs = 1 })

vim.api.nvim_create_user_command("PetsKillAll", function()
    pets.kill_all()
end, {})

vim.api.nvim_create_user_command("PetsList", function()
    pets.list()
end, {})
