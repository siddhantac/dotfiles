local M = {}
M.setup = function()
    require("neotest").setup({
        consumers = {
            overseer = require("neotest.consumers.overseer"),
        },
        adapters = {
            require("neotest-go")({
                -- experimental = {
                --     test_table = true,
                --     note(2023-07-21): enabling this causes neotest to not be able to find any tests
                -- },
                -- note(2023-07-21): these seem unnecessary
                -- args = { "-count=1", "-timeout=60s" },
            }),
        },
    })
end

-- use if required for Pablo
-- env = {
--     AWS_SECRET_ACCESS_KEY = '123',
--     AWS_ACCESS_KEY_ID = '123',
--     DH_SPEC_FILE = '/Users/s.c/workspace/deliveryhero/pd-pablo-payment-gateway/deployments/development/spec_local.yaml',
-- },

return M
