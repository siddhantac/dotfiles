return {
    {
        'nvim-treesitter/nvim-treesitter',
        name = 'treesitter',
        branch = "main",
        -- NOTE: lazy-loading is NOT supported by the new nvim-treesitter main branch.
        -- It must be loaded eagerly.
        lazy = false,
        build = ":TSUpdate",
        config = function()
            -- The new API only accepts install_dir in setup().
            -- All other options (highlight, indent, ensure_installed) are removed.
            require('nvim-treesitter').setup({
                install_dir = vim.fn.stdpath('data') .. '/site',
            })

            -- Install parsers (runs asynchronously)
            require('nvim-treesitter').install({
                "bash",
                "csv",
                "go",
                "gomod",
                "gowork",
                "gosum",
                "json",
                "ledger",
                "lua",
                "markdown",
                "markdown_inline",
                "python",
            })

            -- Enable treesitter highlighting and indentation per filetype via autocmd.
            -- Highlighting is now a built-in Neovim feature (`:h treesitter-highlight`).
            -- Indentation is provided by the plugin but still experimental.
            vim.api.nvim_create_autocmd('FileType', {
                pattern = {
                    'bash', 'sh', 'go', 'gomod', 'gowork', 'gosum',
                    'json', 'lua', 'markdown', 'python', 'csv', 'ledger',
                },
                callback = function()
                    vim.treesitter.start()
                    -- Experimental treesitter indentation
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        'nvim-treesitter/nvim-treesitter-context',
        lazy = false,
        keys = {
            { '[x', function() require('treesitter-context').go_to_context() end },
        },
    }
}
