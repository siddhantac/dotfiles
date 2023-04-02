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
