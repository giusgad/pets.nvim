local M = {}

M.Pet = {}
M.Pet.__index = M.Pet

-- @param name the actual name for the pet
-- @param type the species of the pet e.g. cat
-- @param style the color/style of the pet e.g. brown
-- @param user_opts the table with user options
-- @return a new Pet instance
function M.Pet.new(name, type, style, user_opts, state)
    local instance = setmetatable({}, M.Pet)
    instance.name = name
    instance.type = type
    instance.style = style
    instance.death_animation = user_opts.death_animation
    instance.state = state

    local wd = debug.getinfo(1).source:sub(2):match("(.*nvim/)") .. "media/"
    instance.sourcedir = wd .. type .. "/" .. style .. "/"

    instance.popup = require("nui.popup")(user_opts.popup)
    instance.animation = require("pets.animations").Animation.new(
        instance.sourcedir,
        type,
        style,
        instance.popup,
        user_opts,
        instance.state
    )
    return instance
end

-- start the animation of the pet
function M.Pet:animate()
    if self.animation.row <= 0 or self.animation.row > 10 then
        vim.notify("Row must be >= 1 and <= 10. Check your config", vim.log.levels.ERROR)
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

function M.Pet:set_paused(paused)
    self.state.paused = paused
    self.animation:set_state({
        paused = paused,
    })
end

function M.Pet:set_hidden(hidden)
    self.state.hidden = hidden
    self.state.paused = hidden

    self.animation:set_state({
        hidden = hidden,
        paused = hidden,
    })
end

function M.Pet:set_sleep(sleeping)
    self.animation:set_state({ sleeping = sleeping })
end

return M
