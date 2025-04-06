return {
    {
        'nvim-orgmode/orgmode',
        ft = { 'org' },
        dependencies = {
            {
                'akinsho/org-bullets.nvim',
                config = function()
                    require('org-bullets').setup()
                end
            }
        },
        config = function()
            -- Setup orgmode
            require('orgmode').setup({
                org_agenda_files = '~/workspace/deliveryhero/todos/**/*',
                org_default_notes_file = '~/workspace/deliveryhero/todos/refile.org',
                org_todo_keywords = { 'TODO', 'DOING', '|', 'DONE' },
                org_capture_templates = {
                    r = {
                        description = "Repo",
                        template = "* [[%x][%(return string.match('%x', '([^/]+)$'))]]%?",
                        target = "~/org/repos.org",
                    }
                },
            })

            -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
            -- add `org` to ignore_install
            -- require('nvim-treesitter.configs').setup({
            --   ensure_installed = 'all',
            --   ignore_install = { 'org' },
            -- })
        end,
    },
    {
        "vimwiki/vimwiki",
        init = function()
            -- Setting vimwiki configuration in Lua
            vim.g.vimwiki_list = {
                {
                    syntax = 'markdown',
                    ext = 'md'
                }
            }
        end
    },
}
