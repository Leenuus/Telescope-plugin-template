local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local previewers = require("telescope.previewers")
local utils = require("telescope.previewers.utils")

local logger = require("plenary.log")

local result = {
  "I am the 1th entry",
  "I am the 2nd entry",
  "I am the 3rd entry",
}

local simple_picker = function(opts)
  opts = opts or {}
  pickers
      .new(opts, {
        prompt_title = "select a entry",
        finder = finders.new_table({
          results = result,
          entry_maker = function(entry)
            return {
              value = entry,
              -- NOTE: display is show as entry in telescope main window
              display = entry,
              -- NOTE: ordinal is used to match user input, sort the result
              ordinal = entry,
              -- NOTE: other keys can be added
            }
          end,
        }),
        -- NOTE: use default picker
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          -- NOTE: do something with selected item here
          -- this function change default select action
          -- by default it will open a new buffer with a name same as the value field
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            logger.info(selection)
          end)
          return true
        end,
        -- NOTE: previewer open a new window holding a buffer
        -- showing the detail of entry to user
        previewer = previewers.new_buffer_previewer({
          define_preview = function(self, entry, status)
            local lines = vim.split(entry["value"], "\n")
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, lines)
            utils.highlighter(self.state.bufnr, "markdown")
          end,
        }),
      })
      :find()
end

-- uncommon this line, and source this file to test the picker
-- simple_picker()

local command_result_picker = function(opts)
  opts = opts or {}
  pickers
      .new(opts, {
        prompt_title = "select a entry",
        finder = finders.new_oneshot_job({
          -- NOTE: command to execute
          "fd",
          ".",
          "/usr/bin",
        }, {
          entry_maker = function(entry)
            -- NOTE: entry is command stdout, split by line
            -- pitfall here is that you won't be able to get all lines at once
            -- you should not rely on the **whole** output of the command
            logger.info(entry) -- this is useful when developing and debugging your plugin
            return {
              value = entry,
              display = entry,
              ordinal = entry,
            }
          end,
        }),

        -- NOTE: use default picker
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          -- NOTE: do something with selected item here
          -- this function change default select action
          -- by default it will open a new buffer with a name same as the value field
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            -- here we simple log the result
            logger.info(selection)
          end)
          return true
        end,
        previewer = previewers.new_buffer_previewer({
          define_preview = function(self, entry, status)
            local lines = vim.split(entry["value"], "\n")
            vim.api.nvim_buf_set_lines(self.state.bufnr, 0, 0, true, lines)
            utils.highlighter(self.state.bufnr, "markdown")
          end,
        }),
      })
      :find()
end

-- uncommon this line and source this file in nvim to test
-- command_result_picker()

-- NOTE: this file should return things like this to be loaded by telescope
return require("telescope").register_extension({
  setup = function(ext_config, config) end,
  exports = {
    -- NOTE: name it the same as plugin name, so it can be access without pain
    -- this is always a picker you want to export
    ["your_extension"] = simple_picker,
    -- NOTE: this picker can be call with
    -- :Telescope your_extension subcommand
    ["subcommand"] = command_result_picker,
    -- you can also export other things, such as sorters or previewers ...
  },
})
