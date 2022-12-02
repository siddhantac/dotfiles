require ('which-key').register(
  {
      e = { ":e <C-R>=expand('%:p:h') . '/' <CR>", "Edit file in same dir" },
      v = { ":vsplit <C-R>=expand('%:p:h') . '/' <CR>", "Vsplit file in same dir" }
  },
  { prefix = "," }
)

require ('which-key').register(
  {
      p = {
        name = "Packer",
        s = { "<cmd>PackerSync<cr>", "Sync" },
        c = { "<cmd>PackerClean<cr>", "Clean" },
        u = { "<cmd>PackerUpdate<cr>", "Update" },
        t = { "<cmd>PackerStatus<cr>", "Status" },
        i = { "<cmd>PackerInstall<cr>", "Install" },
      },

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

      g = {
          name = "Git",
          g = {"<cmd>Git<CR>", "Open vim-fugitive"},
          c = {"<cmd>Git commit<CR>", "Commit"},
          a = {"<cmd>Git add -A|Git commit<CR>", "Add and commit"},

          l = {"<cmd>Dispatch git pull<CR>", "Pull"},
          y = {"<cmd>!git pull --all -p<CR>", "Sync"},

          p = {"<cmd>Dispatch git push<CR>", "Push"},
          n = {"<cmd>Dispatch git push --no-verify<CR>", "Push without verify"},

          s = {"<cmd>!git status --short<CR>", "Status"},
          o = {"<cmd>GBrowse<CR>", "Open in GitHub (browser)"}, -- uses tpope/vim-rhubarb
      },

      d = {
          name = "Diagnostics",
          -- n = {"<cmd>lua vim.diagnostic.goto_next()<CR>", "Next"},
          -- p = {"<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev"},
          f = {"<cmd>Telescope diagnostics<CR>", "Open in Telescope"},
          L = {"<cmd>lua vim.diagnostic.setloclist()<CR>", "Open in location list"},

          n = {"<cmd>Lspsaga diagnostic_jump_next<CR>", "Next"},
          p = {"<cmd>Lspsaga diagnostic_jump_prev<CR>", "Prev"},
          d = {"<cmd>Lspsaga show_line_diagnostics<CR>", "Show line diagnostic"},
          D = {"<cmd>Lspsaga show_cursor_diagnostics<CR>", "Show cursor diagnostic"},
      },

      e = { "<cmd>NvimTreeFindFileToggle<CR>", "File Explorer" },
      w = {"<cmd>w<CR>", "Save"},
      s = {"<cmd>Telescope live_grep<CR>", "Search (live_grep)"}
    },
    { prefix = "<leader>" }
)

