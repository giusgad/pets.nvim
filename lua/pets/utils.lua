local M = {}

function M.ShowPet(buf, offset_rows, offset_cols, pet_name, pet_style)
    local wd = "/mnt/shared/coding/lua/plugins/pets.nvim/media/" -- TODO: adapt to use the correct path when plugin is installed
    local sourcedir = wd .. pet_name .. "/" .. pet_style .. "/"

    require("pets.animations").animate(buf, sourcedir)

    -- local image = require("hologram.image"):new(sourcedir .. "8fps/walk/0.png", {})
    -- image:display(1 + offset_rows, 0 + offset_cols, buf, {}) -- TODO: offset option to show the pet at the desired height
    return -1
end

function M.listdir(directory)
    local i, t, popen = 0, {}, io.popen
    local pfile = popen('/bin/ls -a "' .. directory .. '"')
    if pfile == nil then
        error("Error getting assets for specified pet")
    end
    for filename in pfile:lines() do
        if filename ~= "." and filename ~= ".." then
            i = i + 1
            t[i] = filename
        end
    end
    pfile:close()
    return t
end

return M
