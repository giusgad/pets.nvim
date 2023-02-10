local M = {}
M.Pet = {}
M.Pet.__index = M.Pet

-- @param name the actual name for the pet
-- @param type the species of the pet e.g. cat
-- @param style the color/style of the pet e.g. brown
-- @return a new Pet instance
function M.Pet.new(name, type, style)
    local instance = setmetatable({}, M.Pet)
    instance.name = name
    instance.type = type
    instance.style = style

    local wd = debug.getinfo(1).source:sub(2):match("(.*nvim/)") .. "media/"
    instance.sourcedir = wd .. type .. "/" .. style .. "/"

    instance.animation = require("pets.animations").Animation.new(instance.sourcedir, type, style)
    instance.popup = require("pets.popup").popup
    return instance
end

function M.Pet:animate()
    self.popup:mount()
    self.animation:start(self.popup.bufnr)
end

function M.Pet:kill()
    self.popup:unmount()
    self.animation:stop()
end

return M
