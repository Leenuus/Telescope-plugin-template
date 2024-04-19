# A Telescope plugin work with mpd

A simple telescope plugin template, feel free to copy it

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
