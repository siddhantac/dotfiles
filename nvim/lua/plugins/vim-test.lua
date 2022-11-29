vim.g['test#go#minitest#options'] = '-v'
vim.g['test#strategy'] = {
  nearest = 'dispatch',
  file =    'dispatch',
  suite =   'basic'
}

local function goTestFilename(openType)
                  local filename = vim.api.nvim_buf_get_name(0)
                  -- modify the filename to add _test
                  local l = string.len(filename)
                  local fileWithoutExt = string.sub(filename, 0, l-3)
                  local testFilename = fileWithoutExt .. "_test.go"
                  -- open the test file
                  vim.cmd(openType .. testFilename)
end

vim.api.nvim_create_user_command(
    'OpenGoTestFile',
              function()
                  goTestFilename('e')
              end,
    { nargs = 0 }
)

vim.api.nvim_create_user_command(
    'OpenGoTestFileVSplit',
              function()
                  goTestFilename('vs')
              end,
    { nargs = 0 }
)

require ('which-key').register(
  {
      t = {
          name = "Test",
          n = {"<cmd>TestNearest<cr>", "run test nearest to cursor"},
          f = {"<cmd>TestFile<cr>", "run test file"},
          s = {"<cmd>TestSuite<cr>", "run entire test suite"},
          t = {"<cmd>TestLast<cr>", "run the last test"},
          e = { "<cmd>OpenGoTestFile<cr>", "open file"},
          v = { "<cmd>OpenGoTestFileVSplit<cr>", "open file in vert split"},
      }
    },
    { prefix = "<leader>" }
)
