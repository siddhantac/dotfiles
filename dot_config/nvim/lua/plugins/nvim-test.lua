require('nvim-test').setup({
    term = "toggleterm",
    termOpts = {
        direction = "horizontal",
    }
})
require('nvim-test.runners.go-test'):setup {
    -- settings needed for pd-pablo
    env = {
        AWS_SECRET_ACCESS_KEY = '123',
        AWS_ACCESS_KEY_ID = '123',
        DH_SPEC_FILE = '/Users/s.c/workspace/deliveryhero/pd-pablo-payment-gateway/deployments/development/spec_local.yaml',
    },
}

require ('which-key').register(
  {
      t = {
          name = "Test",
          n = {"<cmd>TestNearest AWS_SECRET_ACCESS_KEY=123 AWS_ACCESS_KEY_ID=123 DH_SPEC_FILE=$(pwd)/deployments/development/spec_local.yaml<cr>", "run test nearest to cursor"},
          f = {"<cmd>TestFile<cr>", "run test file"},
          s = {"<cmd>TestSuite<cr>", "run entire test suite"},
          t = {"<cmd>TestLast<cr>", "run the last test"},
          -- e = { "<cmd>OpenGoTestFile<cr>", "open file"},
          -- v = { "<cmd>OpenGoTestFileVSplit<cr>", "open file in vert split"},
      }
    },
    { prefix = "<leader>" }
)
