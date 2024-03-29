local M = {}
M.opts = {
    -- symbol = "▏",
    symbol = "│",
    options = { try_as_border = true },
}
M.init = function()
    vim.api.nvim_create_autocmd("FileType", {
        pattern = {
            "help",
            "alpha",
            "dashboard",
            "neo-tree",
            "Trouble",
            "lazy",
            "mason",
            "notify",
            "toggleterm",
            "lazyterm",
        },
        callback = function()
            vim.b.miniindentscope_disable = true
        end,
    })
end

return M

-- {
--     "folke/noice.nvim",
--     event = "VeryLazy",
--     opts = {
--         lsp = {
--             -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--             override = {
--                 ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--                 ["vim.lsp.util.stylize_markdown"] = true,
--                 ["cmp.entry.get_documentation"] = true,
--             },
--         },
--         -- you can enable a preset for easier configuration
--         presets = {
--             bottom_search = true,         -- use a classic bottom cmdline for search
--             command_palette = true,       -- position the cmdline and popupmenu together
--             long_message_to_split = true, -- long messages will be sent to a split
--             inc_rename = false,           -- enables an input dialog for inc-rename.nvim
--             lsp_doc_border = true,        -- add a border to hover docs and signature help
--         },
--
--         -- hide `written` messages
--         -- https://github.com/folke/noice.nvim/wiki/Configuration-Recipes#hide-written-messages
--         routes = {
--             {
--                 filter = {
--                     event = "msg_show",
--                     kind = "",
--                     find = "written",
--                 },
--                 opts = { skip = true },
--             },
--         },
--     },
--     dependencies = {
--         -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
--         "MunifTanjim/nui.nvim",
--         -- OPTIONAL:
--         --   `nvim-notify` is only needed, if you want to use the notification view.
--         --   If not available, we use `mini` as the fallback
--         "rcarriga/nvim-notify",
--     }
-- },
