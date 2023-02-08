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
    return instance
end

function M.Pet:animate(bufnr)
    require("pets.animations").animate(bufnr, self.sourcedir)
end

return M
