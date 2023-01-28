local pets = require("pets")

local ok = pcall(require, "hologram")
if ok then
    require("hologram").setup({ auto_display = false })
end

vim.api.nvim_create_user_command("PetsShow", function()
    pets.show()
end, {}) -- use  nargs = 1 to accept arguments
