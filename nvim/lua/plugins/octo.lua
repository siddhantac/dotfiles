local M = {}
M.setup = function()
    require "octo".setup({
        mappings = {
            submit_win = {
                approve_review = { lhs = "<leader>a", desc = "approve review" },
                comment_review = { lhs = "<leader>m", desc = "comment review" },
                request_changes = { lhs = "<leader>r", desc = "request changes review" },
                close_review_tab = { lhs = "<C-c>", desc = "close review tab" },
            },
        }
    })
end

return M
