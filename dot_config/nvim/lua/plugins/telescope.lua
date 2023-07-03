local spec = {
      'nvim-telescope/telescope.nvim',
      name = "telescope.nvim",
      dependencies = {
        'nvim-lua/plenary.nvim',
      },
}

function spec:config()
    require('telescope').setup{
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,layout_config = {
          -- other layout configuration here
        -- path_display = "shorten",
        mappings = {
          i = {
          ["<esc>"] = require('telescope.actions').close,
          ['<c-d>'] = require('telescope.actions').delete_buffer,
            -- map actions.which_key to <C-h> (default: <C-/>)
            -- actions.which_key shows the mappings for your picker,
            -- e.g. git_{create, delete, ...}_branch for the git_branches picker
            -- ["<C-h>"] = "which_key"
          },
        },
      },
      pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
            lsp_document_symbols = {
                theme = "dropdown",
            },
            lsp_references = {
                theme = "dropdown",
            },
            find_files = {
                theme = "dropdown",
                hidden = true,
            },
      },
      extensions = {
        -- Your extension configuration goes here:
        -- extension_name = {
        --   extension_config_key = value,
        -- }
        -- please take a look at the readme of the extension you want to configure
      }
    }
end

return spec
