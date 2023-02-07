local M = {}
M.timer = nil
M.bufnr = nil
M.frame_counter = 1
M.frames = {}
M.current_image = nil

local lines = {}
local string = ""
for _ = 0, 150 do
    string = string .. " "
end
for _ = 0, 15 do
    table.insert(lines, string)
end

function M.animate(buf, sourcedir, fps)
    local files = M._listdir(sourcedir .. "8fps/" .. "walk/")
    for _, file in pairs(files) do
        table.insert(M.frames, sourcedir .. "8fps/" .. "walk/" .. file)
    end
    M.timer = vim.loop.new_timer()
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

function M._listdir(directory)
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
