# Pets.nvim
## 📦 Installation
Install with your favorite package manager! Examples:
With packer:
```lua
use({
  "giusgad/pets.nvim",
  config = function()
    require("pets").setup({
      -- your options
    })
  end,
  requires = {
    "edluffy/hologram.nvim",
    "MunifTanjim/nui.nvim",
  }
})
```
With lazy:
```lua
{
  "giusgad/pets.nvim",
  dependencies = { "MunifTanjim/nui.nvim", "edluffy/hologram.nvim" },
  config=true,
  opts={
    -- your options
  }
}
```
## ⚙️ Configuration
This is the default configuration:
```lua
{
  row = 5, -- the row (height) to display the pet at
  col = 0, -- the column to display the pet at (set to high number to have it stay still on the right side)
  speed_multiplier = 1, -- you can make your pet move faster/slower. If slower the animation will have lower fps.
  default_pet = "cat", -- the pet to use for the PetNew command
  default_style = "brown", -- the style of the pet to use for the PetNew command
  random = false, -- wether to use a random pet for the PetNew command, ovverides default_pet and default_style
}
```
## Usage - commands
These are all the available commands:
- `PetsNew {name}`: creates a pet with the style and type defined by the configuration, and name {name}
- `PetsNewCustom {type} {style} {name}`: creates a new pet with type, style and name specified in the command
- `PetsList`: prints the names of all the pets that are currently alive
- `PetsKill {name}`: kills the pet with given name, which will immediately blink out of existence. Forever.
- `PetsKillAll`: kills all the pets, poor creatures.
## Limitations
This plugin relies on [hologram.nvim](https://github.com/edluffy/hologram.nvim) to display the images,
and shares all of its limitations. Here are the most significant ones:
- Only works with terminal emulators that support the [kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/)
- Doesn't currently work inside tmux
## Credits
All the beautiful cat assets were designed by [SeethingSwarm](https://seethingswarm.itch.io/catset)
