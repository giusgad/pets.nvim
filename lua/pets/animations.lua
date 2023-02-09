local M = {}
M.Animation = {}
M.Animation.__index = M.Animation

-- lines to insert in the buffer to avoid image stretching
local lines = {}
local string = ""
for _ = 0, 150 do
    string = string .. " "
end
for _ = 0, 15 do
    table.insert(lines, string)
end

function M.Animation.new(sourcedir, type, style)
    local instance = setmetatable({}, M.Animation)
    instance.type = type
    instance.style = style
    instance.sourcedir = sourcedir
    instance.frame_counter = 1
    instance.frames = {}
    return instance
end

function M.Animation:start(bufnr)
    local files = require("pets.utils").listdir(self.sourcedir .. "walk/")
    for _, file in pairs(files) do
        table.insert(self.frames, self.sourcedir .. "walk/" .. file)
    end
    if self.timer ~= nil then
        self.timer = nil
    end
    self.timer = vim.loop.new_timer()
    self.bufnr = bufnr

    self.timer:start(100, 1000 / 8, function()
        vim.schedule(function()
            M.Animation.next_frame(self)
        end)
    end) -- TODO: try timeout = 0
end

function M.Animation:next_frame()
    self.frame_counter = self.frame_counter + 1
    vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, lines)
    if not self.current_image then
        self.frame_counter = 1
    else
        self.current_image:delete(0, { free = false })
    end
    if self.frame_counter > #self.frames then
        self.frame_counter = 1
    end
    local image = require("hologram.image"):new(self.frames[self.frame_counter])
    image:display(1, self.frame_counter, self.bufnr, {})
    self.current_image = image
end

return M
