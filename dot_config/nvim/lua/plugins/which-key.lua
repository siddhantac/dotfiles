local spec = {
	"folke/which-key.nvim",
	name = "which-key.nvim",
}

function spec:config()
	local whichkey = require ('which-key')

    whichkey.register(
	  {
	      e = { ":e <C-R>=expand('%:p:h') . '/' <CR>", "Edit file in same dir" },
	      v = { ":vsplit <C-R>=expand('%:p:h') . '/' <CR>", "Vsplit file in same dir" }
	  },
	  { prefix = "," }
	)

	whichkey.register(
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
            f = { "<cmd>Telescope find_files<cr>", "Find files" },
            F = { "<cmd>Telescope find_files layout_strategy=vertical<cr>", "Find files (vert)" },
            d = { "<cmd>Telescope find_files search_dirs=%:p:h<CR>", "Find Files in same dir", noremap=false },
            g = { "<cmd>Telescope git_branches<cr>", "Git branches" },
            t = { "<cmd>Telescope treesitter<cr>", "treesitter" },
          },

          b = {
              name = "Buffers",
              b = {"<cmd>b#<CR>", "Swap"},
              f = {"<cmd>Telescope buffers<CR>", "Find"},
              c = {"<cmd>close<CR>", "Close"},
              d = {"<cmd>bd<CR>", "Delete"},
              D = {"<cmd>bufdo bd<CR>", "Delete all"},
              m = {"<cmd>MaximizerToggle<CR>", "Maximize (toggle)"},
          },

          c = {
              name = "Config",
              r = { "<cmd>source ~/.config/nvim/init.lua<CR>", "Reload config" },
          },

          g = {
              name = "Git",
              g = {"<cmd>Git<CR>", "vim-fugitive"},
              c = {"<cmd>Git commit<CR>", "commit"},
              a = {"<cmd>Git add -A|Git commit<CR>", "add + commit"},

              l = {"<cmd>Dispatch git pull<CR>", "pull"},
              y = {"<cmd>!git pull --all -p<CR>", "sync"},

              p = {"<cmd>Git push<CR>", "push"},
              n = {"<cmd>Dispatch git push --no-verify<CR>", "push without verify"},
              m = {"<cmd>Git push --no-verify<CR>", "push without verify2"},

              s = {"<cmd>!git status --short<CR>", "status"},
              o = {"<cmd>GBrowse<CR>", "open github (browser)"}, -- uses tpope/vim-rhubarb

              x = {"<cmd>Git add -A|Git commit|Git push<CR>", "add + commit + push"},
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
	      s = {"<cmd>Telescope live_grep<CR>", "Search (live_grep)"},
	      n = {
              name = "Sessions",
              l = { "<cmd>lua MiniSessions.select()<CR>", "Load session" },
              w = { "<cmd>lua MiniSessions.write('nil')<CR>", "Write session" },
              d = { "<cmd>lua MiniSessions.select('delete')<CR>", "Delete session" },
            },
	    },
	    { prefix = "<leader>" }
	)
end

return spec
