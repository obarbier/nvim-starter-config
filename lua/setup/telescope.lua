-- Telescope Global remapping
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local fb_actions = require("telescope._extensions.file_browser.actions")

require("telescope").setup({
  defaults = {
    sorting_strategy = "descending",
    prompt_prefix = "   ",
    winblend = 25,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "ivy",
      hidden = true,
      mappings = {
        ["i"] = {
          ["<S-M>"] = fb_actions.move,
        },
      },
    },
  },
  pickers = {
    find_files = {
      theme = "ivy",
    },
    live_grep = {
      theme = "ivy",
    },
    buffers = {
      theme = "ivy",
      sort_mru = true,
      ignore_current_buffer = true,
      mappings = {
        i = {
          ["<C-w>"] = "delete_buffer",
        },
        n = {
          ["<C-w>"] = "delete_buffer",
        },
      },
    },
  },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("session-lens")
require("telescope").load_extension("file_browser")