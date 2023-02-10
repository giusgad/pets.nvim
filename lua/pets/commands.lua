local pets = require("pets")

vim.api.nvim_create_user_command("PetsNew", function(input)
    pets.create_pet(input.args, "cat", "brown")
end, { nargs = 1 })

vim.api.nvim_create_user_command("PetsKillAll", function()
    pets.kill_all()
end, {})
