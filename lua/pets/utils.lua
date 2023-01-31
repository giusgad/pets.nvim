local M = {}

function M.ShowPet(buf)
  local source = "/mnt/shared/coding/lua/plugins/pets.nvim/media/test/brown_idle-0.png"
  local image = require("hologram.image"):new(source, {})

  image:display(5, 0, buf, {}) -- TODO: offset option to show the pet at the desired height
  return image
end

return M
