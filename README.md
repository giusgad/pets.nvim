# pets.nvim
Pets.nvim is a plugin that provides the missing core functionality of showing little animal friends inside your editor.
It relies on the [kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/) and [hologram.nvim](https://github.com/edluffy/hologram.nvim) to be able to display images in a terminal window.
As you might know the plugin is heavily inspired by [vscode-pets](https://github.com/tonybaloney/vscode-pets/tree/master/media).

![pets.gif](./pets.gif)

## 📦 Installation

Install with your favorite package manager!

Examples:

With packer:
```lua
use({
  "giusgad/pets.nvim",
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
}
```
And then call 
```lua
require("pets").setup({
  -- your options here
})
```

## ⚙️ Configuration

This is the default configuration:
```lua
{
  row = 1, -- the row (height) to display the pet at (must be at least 1 and at most 10)
  col = 0, -- the column to display the pet at (set to high number to have it stay still on the right side)
  speed_multiplier = 1, -- you can make your pet move faster/slower. If slower the animation will have lower fps.
  default_pet = "cat", -- the pet to use for the PetNew command
  default_style = "brown", -- the style of the pet to use for the PetNew command
  random = false, -- wether to use a random pet for the PetNew command, ovverides default_pet and default_style
  death_animation = true, -- animate the pet's death, set to false to feel less guilt
}
```

## 🐾 Available pets

- cat:
    - black
    - red
    - brown
    - dark_grey
    - light_grey

## 📑 Usage - commands

These are all the available commands:
- `PetsNew {name}`: creates a pet with the style and type defined by the configuration, and name {name}
- `PetsNewCustom {type} {style} {name}`: creates a new pet with type, style and name specified in the command
- `PetsList`: prints the names of all the pets that are currently alive
- `PetsKill {name}`: kills the pet with given name, which will immediately blink out of existence. Forever.
- `PetsKillAll`: kills all the pets, poor creatures. Works just as PetsKill but for every pet.
- `PetsPauseToggle`: pause/resume animations for all pets, leaving them on screen as cute little statues
- `PetsHideToggle`: pause the animation for all pets and hide them / show all the pets again and resume animations

## ⚠️ Limitations

This plugin relies on [hologram.nvim](https://github.com/edluffy/hologram.nvim) to display the images,
and shares all of its limitations. Here are the most significant ones:
- Only works with terminal emulators that support the [kitty graphics protocol](https://sw.kovidgoyal.net/kitty/graphics-protocol/)
    To be more precise the only terminal I tested where I was able to have the protocol working correctly is kitty itself.
- Doesn't currently work inside tmux

## ✔️ Roadmap
- [ ] Handle window resizes
- [ ] add more pets
- [ ] add an option to change the pet's size

## 👏 Credits

All the beautiful cat assets were designed by [SeethingSwarm](https://seethingswarm.itch.io/catset)
