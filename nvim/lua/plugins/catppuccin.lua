local telescopeBorderless = function(flavor)
    local cp = require("catppuccin.palettes").get_palette(flavor)

    return {
        TelescopeMatching = { fg = cp.flamingo },
        TelescopeSelection = { fg = cp.text, bg = cp.surface0, bold = true },

        TelescopePromptPrefix = { bg = cp.surface0 },
        TelescopePromptNormal = { bg = cp.surface0 },
        TelescopePromptBorder = { bg = cp.surface0, fg = cp.surface0 },
        TelescopePromptTitle = { bg = cp.pink, fg = cp.mantle },

        TelescopeResultsNormal = { bg = cp.mantle },
        TelescopeResultsBorder = { bg = cp.mantle, fg = cp.mantle },
        TelescopeResultsTitle = { fg = cp.mantle },

        TelescopePreviewNormal = { bg = cp.crust },
        TelescopePreviewBorder = { bg = cp.crust, fg = cp.crust },
        TelescopePreviewTitle = { bg = cp.green, fg = cp.mantle },
    }
end

return {
    "catppuccin/nvim",
    priority = 1,
    config = function()
        require("catppuccin").setup({
            integrations = {
                telescope = { enabled = true },
                harpoon = true,
                lsp_saga = true,
                mini = true,
                neotest = true,
                notify = true,
                nvimtree = true,
                which_key = true,
                -- gitsigns = true,
            },
            highlight_overrides = {
                latte = telescopeBorderless('latte'),
                frappe = telescopeBorderless('frappe'),
                macchiato = telescopeBorderless('macchiato'),
                mocha = telescopeBorderless('mocha'),
            }
        })
    end
}
