local M = {}
M.Pet = {}
M.Pet.__index = M.Pet

function M.Pet.new(name, type, style)
    local instance = setmetatable({}, M.Pet)
    instance.name = name
    instance.type = type
    instance.style = style
    local wd = "/mnt/shared/coding/lua/plugins/pets.nvim/media/" -- TODO: adapt to use the correct path when plugin is installed
    instance.sourcedir = wd .. type .. "/" .. style .. "/"
    instance.animation = require("pets.animations").Animation.new(instance.sourcedir, type, style)
    return instance
end

function M.Pet:animate(bufnr)
    self.animation:start(bufnr)
end

return M
