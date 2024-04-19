# A Telescope plugin Template

A simple telescope plugin template, feel free to copy it

This repo is not for documenting every API Telescope provides, but you can familiar yourself with common used ones here.

## Directory Structure

### A Very Simple One

```
└── lua
    └── telescope
        └── _extensions         # The underscore is significant
            └─ plugin_name.lua  # Init and register your extension
```

### A Complex One

```
.
└── lua
    └── telescope
        └── _extensions         # The underscore is significant
            └─ plugin_name.lua  # Require, init and register your extension
            └─ plugin_name
                └─ file1.lua
                └─ file2.lua
```

### A More Complex One

```
.
└── lua
    ├── plugin_name             # Your actual plugin code
    │   ├── init.lua
    │   └── some_file.lua
    └── telescope
        └── _extensions         # The underscore is significant
            └─ plugin_name.lua  # Require, init and register your extension

```

## Some Suggestions

### if you are not familiar with lua:

- [*Neovim* lua guide](https://github.com/nanotee/nvim-lua-guide)

### Helpful Resources:

- [*Developer Voices*, an amazing video writing simple telescope plugin, also showing you amazing debug skills](https://www.youtube.com/watch?v=HXABdG3xJW4)
- [Telescope Official Developer Guide](https://github.com/nvim-telescope/telescope.nvim/blob/master/developers.md)
- `:help Telescope` for basic documentations
- You should read the source code too, **some functions are not documented in previous docs**, but they are really well documented in sotrce code! Like `require("telescope").register_extension({mod})`
- [Not Telescope, TJ has a lot of Neovim stuff on his channel, I learn most of my Neovim debugging tricks from his videos](https://www.youtube.com/@teej_dv)
