local M = {}
M.timer = nil
M.bufnr = nil
M.frame_counter = 1
M.frames = {} -- TODO: init frames to be images, not paths
M.current_image = nil

local lines = {}
local string = ""
for _ = 0, 150 do
    string = string .. " "
end
for _ = 0, 15 do
    table.insert(lines, string)
end

function M.animate(buf, sourcedir)
    local files = require("pets.utils").listdir(sourcedir .. "walk/")
    for _, file in pairs(files) do
        table.insert(M.frames, sourcedir .. "walk/" .. file)
    end
    if M.timer == nil then
        M.timer = vim.loop.new_timer()
    else
        print("timer already exists")
    end
    M.bufnr = buf

    M.timer:start(100, 1000 / 8, vim.schedule_wrap(M.next_frame))
end

function M.next_frame()
    M.frame_counter = M.frame_counter + 1
    vim.api.nvim_buf_set_lines(M.bufnr, 0, -1, false, lines)
    if not M.current_image then
        M.frame_counter = 1
    else
        M.current_image:delete(0, { free = false })
    end
    if M.frame_counter > #M.frames then
        M.frame_counter = 1
    end
    local image = require("hologram.image"):new(M.frames[M.frame_counter])
    image:display(1, M.frame_counter, M.bufnr, {})
    M.current_image = image
    return true
end

return M
