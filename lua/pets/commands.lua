local pets = require("pets")

vim.api.nvim_create_user_command("Pets", function()
    pets.show()
end, {}) -- use  nargs = 1 to accept arguments

vim.api.nvim_create_user_command("PetsNew", function(input)
    pets.create_pet("Giulio", "cat", "brown") -- TODO: use input.args as name
end, { nargs = 1 }) -- use  nargs = 1 to accept arguments

vim.api.nvim_create_user_command("PetsCloseAll", function()
    pets.closeAll()
end, {})
