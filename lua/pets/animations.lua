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

-- @param sourcedir the full path for the media directory
-- @param type,style type and style of the pet
-- @param popup the popup where the pet is displayed
-- @param user_opts table with user options
-- @return a new animation instance
function M.Animation.new(sourcedir, type, style, popup, user_opts)
    local instance = setmetatable({}, M.Animation)
    instance.type = type
    instance.style = style
    instance.sourcedir = sourcedir
    instance.frame_counter = 1
    instance.actions = listdir(sourcedir)
    instance.frames = {}
    instance.popup = popup
    instance.diying = false

    -- user options
    instance.row, instance.col = user_opts.row, user_opts.col
    instance.speed_multiplier = user_opts.speed_multiplier
    if user_opts.col > popup.win_config.width - 8 then
        M.base_col = popup.win_config.width - 8
    else
        M.base_col = user_opts.col
    end

    -- setup frames
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

-- @param bufnr buffer number of the popup
-- @function start the animation
function M.Animation:start(bufnr)
    if self.timer ~= nil then -- reset timer
        self.timer = nil
    end
    self.timer = vim.loop.new_timer()
    self.bufnr = bufnr
    self.current_action = "idle"

    self.timer:start(0, 1000 / (self.speed_multiplier * 8), function()
        vim.schedule(function()
            M.Animation.next_frame(self)
        end)
    end)
end

-- @function called on every tick from the timer, go to the next frame
function M.Animation:next_frame()
    self.frame_counter = self.frame_counter + 1

    -- pouplate the buffer with spaces to avoid image distortion
    if vim.api.nvim_buf_is_valid(self.bufnr) then
        vim.api.nvim_buf_set_lines(self.bufnr, 0, -1, false, lines)
    end
    if not self.current_image then
        self.frame_counter = 1
    else
        self.current_image:delete(0, { free = false })
    end
    if self.frame_counter > #self.frames[self.current_action] then -- true every 8 frames
        M.Animation.set_next_action(self)
        if self.dead then
            self.timer = nil
            return
        end
        self.frame_counter = 1
    end
    -- frames contains the images for every action
    local image = self.frames[self.current_action][self.frame_counter]
    M.Animation.set_next_col(self)
    image:display(self.row, self.col, self.bufnr, {})
    self.current_image = image
end

-- @function decide which action comes after the following
function M.Animation:set_next_action()
    if self.dying then
        if self.current_action == "die" then
            self.dead = true
            M.Animation.stop(self)
            self.popup:unmount()
        end
        self.current_action = "die"
        return
    end
    local next_actions = {
        crouch = { "liedown", "sneak", "sit" },
        idle = { "idle_blink", "walk", "sit" },
        idle_blink = { "idle", "walk", "sit" },
        liedown = { "sneak", "crouch" },
        sit = { "idle", "idle_blink", "crouch", "liedown" },
        sneak = { "crouch", "walk", "liedown" },
        walk = { "idle", "idle_blink" },
    }
    if math.random() < 0.5 then
        self.current_action = next_actions[self.current_action][math.random(#next_actions[self.current_action])]
    end
end

-- @function set horizontal movement per frame based on current action
function M.Animation:set_next_col()
    if self.current_action == "walk" then
        if self.col < self.popup.win_config.width - 8 then
            self.col = self.col + 1
        else
            self.col = M.base_col
        end
    elseif self.current_action == "sneak" or self.current_action == "crouch" then
        if self.col < self.popup.win_config.width - 8 then
            if self.frame_counter % 2 == 0 then
                self.col = self.col + 1
            end
        else
            self.col = M.base_col
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
