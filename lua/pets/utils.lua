local M = {}

function M.ShowPet(buf, offset_rows, offset_cols, pet_name, pet_style, fps)
    local wd = "/mnt/shared/coding/lua/plugins/pets.nvim/media/" -- TODO: adapt to use the correct path when plugin is installed
    local sourcedir = wd .. pet_name .. "/" .. pet_style .. "/"

    require("pets.animations").animate(buf, sourcedir, fps)

    -- local image = require("hologram.image"):new(sourcedir .. "8fps/walk/0.png", {})
    -- image:display(1 + offset_rows, 0 + offset_cols, buf, {}) -- TODO: offset option to show the pet at the desired height
    return -1
end

return M
