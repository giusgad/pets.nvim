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

local listdir = require("pets.utils").listdir

function M.Animation.new(sourcedir, type, style)
    local instance = setmetatable({}, M.Animation)
    instance.type = type
    instance.style = style
    instance.sourcedir = sourcedir
    instance.frame_counter = 1
    instance.actions = listdir(sourcedir)
    instance.frames = {}
    for _, action in pairs(instance.actions) do
        local current_actions = {}
        for _, file in pairs(listdir(sourcedir .. action)) do
            local image = require("hologram.image"):new(sourcedir .. action .. "/" .. file)
            table.insert(current_actions, image)
        end
        instance.frames[action] = current_actions
    end
    return instance
end

function M.Animation:start(bufnr)
    if self.timer ~= nil then -- reset timer
        self.timer = nil
    end
    self.timer = vim.loop.new_timer()
    self.bufnr = bufnr
    self.current_action = "idle"

    self.timer:start(0, 1000 / 8, function() -- run timer at 8fps
        vim.schedule(function()
            M.Animation.next_frame(self)
        end)
    end)
end

function M.Animation:next_frame()
    self.frame_counter = self.frame_counter + 1
    vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, lines)
    if not self.current_image then
        self.frame_counter = 1
    else
        self.current_image:delete(0, { free = false })
    end
    if self.frame_counter > #self.frames[self.current_action] then
        self.frame_counter = 1
    end
    local image = self.frames[self.current_action][self.frame_counter]
    image:display(1, self.frame_counter, self.bufnr, {})
    self.current_image = image
end

function M.Animation:stop()
    if self.current_image then
        self.current_image:delete(0, { free = false })
    end
    if self.timer then
        self.timer:stop()
    end
end

return M
