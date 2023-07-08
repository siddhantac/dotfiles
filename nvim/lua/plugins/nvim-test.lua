local spec = {
    "klen/nvim-test",
    name = "nvim-test",
    dependencies = {
        "folke/which-key.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    cmd = {"TestNearest"},
}

function spec:config()
    require('nvim-test').setup({
        -- term = "nvterm",
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
end

return spec
