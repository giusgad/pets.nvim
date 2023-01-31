local M = {}

M.stack = {
  popups = {},
  images = {},
}

function M.setup(options)
  options = options or {}

  -- init hologram
  local ok = pcall(require, "hologram")
  if ok then
    require("hologram").setup({ auto_display = false })
  end

  require("pets.commands") -- init autocommands
end

function M.show()
  local popup = require("pets.popup").popup
  local utils = require("pets.utils")
  popup:mount()

  -- insert lines to avoid the image being stretched
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, { "", "", "", "", "", "", "", "", "", "" })
  popup.buf_options = { -- then set the buffer to be readonly
    modifiable = false,
    readonly = true,
  }

  local image = utils.ShowPet(popup.bufnr)
  table.insert(M.stack.popups, popup)
  table.insert(M.stack.images, image)
end

function M.closeAll()
  for _, image in pairs(M.stack.images) do
    image:delete(0, {
      free = false,
    })
  end
  for _, popup in pairs(M.stack.popups) do
    popup:unmount()
  end
end

return M
