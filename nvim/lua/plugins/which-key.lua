require ('which-key').register(
  {
      e = { ":e <C-R>=expand('%:p:h') . '/' <CR>", "Edit file in same dir" },
      v = { ":vsplit <C-R>=expand('%:p:h') . '/' <CR>", "Vsplit file in same dir" }
  },
  { prefix = "," }
)

require ('which-key').register(
  {
      t = {
          name = "Test",
          n = {"<cmd>TestNearest<cr>", "run test nearest to cursor"},
          f = {"<cmd>TestFile<cr>", "run test file"},
          s = {"<cmd>TestSuite<cr>", "run entire test suite"},
          t = {"<cmd>TestLast<cr>", "run the last test"},
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

      l = {
          name = "LSP",
          i = {vim.lsp.buf.implementation, "Implementation"},
          s = {vim.lsp.buf.signature_help, "Signature help"},
          h = {vim.lsp.buf.hover, "Hover"},
          y = {vim.lsp.buf.type_definition, "Go to type def"},
          d = {vim.lsp.buf.definition, "Go to def"},
          n = {vim.lsp.buf.rename, "Rename"},
          r = {vim.lsp.buf.references, "References in loc list"},
          R = {':Telescope lsp_references<CR>', "References in Telescope"},

      },

      c = {
          name = "Comment",
          c = { "gcc", "Linewise comment" },
          b = { "gcb", "Blockwise comment" },
      },

      e = { "<cmd>NvimTreeFindFileToggle<CR>", "File Explorer" },
      w = {"<cmd>w<CR>", "Save"},
      s = {"<cmd>Telescope live_grep<CR>", "Search"}
    }, 
    { prefix = "<leader>" }
)

