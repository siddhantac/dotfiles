local spec = {
    "glepnir/lspsaga.nvim",
      name = 'lspsaga.nvim',
      event = "LspAttach",
      dependencies = {
        'kyazdani42/nvim-web-devicons',
      },
}

function spec:config()
    -- import lspsaga safely
    local saga_status, saga = pcall(require, "lspsaga")
    if not saga_status then
      return
    end

    saga.setup({
      -- keybinds for navigation in lspsaga window
      move_in_saga = { prev = "<C-k>", next = "<C-j>" },
      -- use enter to open file with finder
      finder = {
          keys = {
            open = "<CR>",
            vsplit = '<C-v>',
            split = '<C-h>',
            tabe = '<C-t>',
            quit = {'q', '<ESC>'},
            close_in_preview = "<Esc>",
          }
      },
      -- use enter to open file with definition preview
      definition = {
        edit = "<CR>",
        vsplit = '<C-v>',
        split = '<C-h>',
        tabe = '<C-t>',
        quit = 'q',
        close = "<Esc>",
      },
    })
end

return spec

