require ('which-key').register(
  {
      e = { ":e <C-R>=expand('%:p:h') . '/' <CR>", "Edit file in same dir" },
      v = { ":vsplit <C-R>=expand('%:p:h') . '/' <CR>", "Vsplit file in same dir" }
  },
  { prefix = "," }
)

require ('which-key').register(
  {
      f = {
            name = "Files",
            f = { "<cmd>Telescope find_files<cr>", "Find File" },
            d = { "<cmd>Telescope find_files search_dirs=%:p:h<CR>", "Find Files in same dir", noremap=false },
          },

      b = {
          name = "Buffers",
          b = {"<cmd>b#<CR>", "Swap"},
          f = {"<cmd>Telescope buffers<CR>", "Find"},
          c = {"<cmd>close<CR>", "Close"},
          d = {"<cmd>bd<CR>", "Delete"},
      },

      c = {
          name = "Config",
          r = { "<cmd>source ~/.config/nvim/init.lua<CR>", "Reload config" },
      },

      e = { "<cmd>NvimTreeFindFileToggle<CR>", "File Explorer" },
      w = {"<cmd>w<CR>", "Save"},
      s = {"<cmd>Telescope live_grep<CR>", "Search (live_grep)"}
    },
    { prefix = "<leader>" }
)

