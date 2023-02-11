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

function M.Animation.new(sourcedir, type, style, row, col, popup_width)
    local instance = setmetatable({}, M.Animation)
    instance.type = type
    instance.style = style
    instance.sourcedir = sourcedir
    instance.frame_counter = 1
    instance.actions = listdir(sourcedir)
    instance.frames = {}
    instance.popup_width = popup_width
    instance.row, instance.col = row, col
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
    if vim.api.nvim_buf_is_valid(self.bufnr) then
        vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, lines)
    end
    if not self.current_image then
        self.frame_counter = 1
    else
        self.current_image:delete(0, { free = false })
    end
    if self.frame_counter > #self.frames[self.current_action] then
        self.frame_counter = 1
    end
    local image = self.frames[self.current_action][self.frame_counter]
    M.Animation.set_next_col(self)
    image:display(self.row, self.col, self.bufnr, {})
    self.current_image = image
end

function M.Animation:set_next_col()
    if self.current_action == "walk" then
        if self.col < self.popup_width - 5 then
            self.col = self.col + 1
        else
            self.col = 0
        end
    elseif self.current_action == "sneak" then
        if self.col < self.popup_width - 8 then
            if self.frame_counter % 2 == 0 then
                self.col = self.col + 1
            end
        else
            self.col = 0
        end
    end
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
