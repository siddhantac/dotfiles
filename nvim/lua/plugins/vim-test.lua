vim.g['test#go#minitest#options'] = '-v'
vim.g['test#strategy'] = {
  nearest = 'dispatch',
  file =    'dispatch',
  suite =   'basic'
}

require ('which-key').register(
  {
      t = {
          name = "Test",
          n = {"<cmd>TestNearest<cr>", "run test nearest to cursor"},
          f = {"<cmd>TestFile<cr>", "run test file"},
          s = {"<cmd>TestSuite<cr>", "run entire test suite"},
          t = {"<cmd>TestLast<cr>", "run the last test"},
      }
    },
    { prefix = "<leader>" }
)
