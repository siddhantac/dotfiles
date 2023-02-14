-- file explorer setup
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  open_on_tab = true,
  update_focused_file = {
      enable = true,
  },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    custom = { "^.git$" }
  },
})
