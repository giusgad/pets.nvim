local M = {}

M.Pet = {}
M.Pet.__index = M.Pet

local popup_opts = {
    position = {
        row = "100%",
        col = "100%",
    },
    size = {
        width = "30%",
        height = 10,
    },
    focusable = false,
    enter = false,
    win_options = {
        winblend = 100,
    },
}

-- @param name the actual name for the pet
-- @param type the species of the pet e.g. cat
-- @param style the color/style of the pet e.g. brown
-- @param user_opts the table with user options
-- @return a new Pet instance
function M.Pet.new(name, type, style, user_opts)
    local instance = setmetatable({}, M.Pet)
    instance.name = name
    instance.type = type
    instance.style = style
    instance.death_animation = user_opts.death_animation

    local wd = debug.getinfo(1).source:sub(2):match("(.*nvim/)") .. "media/"
    instance.sourcedir = wd .. type .. "/" .. style .. "/"

    instance.popup = require("nui.popup")(popup_opts)
    instance.animation =
        require("pets.animations").Animation.new(instance.sourcedir, type, style, instance.popup, user_opts)
    return instance
end

-- start the animation of the pet
function M.Pet:animate()
    if self.animation.row <= 0 then
        vim.notify("Row must be 1 or greater. Check your config", vim.log.levels.ERROR)
        return
    end
    self.popup:mount()
    self.animation:start()
end

-- delete the pet :(
function M.Pet:kill()
    if self.death_animation then
        self.animation.dying = true
    else
        self.animation:stop()
        self.popup:unmount()
    end
end

function M.Pet:toggle_pause()
    if not self.paused then
        self.animation:stop_timer()
        self.paused = true
    else
        if self.animation.current_image then
            self.animation.current_image:delete(0, { free = false })
        end
        self.animation:start_timer()
        self.paused = false
    end
end

function M.Pet:toggle_hide()
    if not self.paused then
        self.animation:stop_timer()
        if self.animation.current_image then
            self.animation.current_image:delete(0, { free = false })
        end
        self.popup:unmount()
        self.paused = true
    else
        self.popup:mount()
        self.animation:start()
        self.paused = false
    end
end

return M
