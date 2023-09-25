-- Easier Navigation
vim.keymap.set('n', '<C-H>', '<C-W><C-H>')
vim.keymap.set('n', '<C-J>', '<C-W><C-J>')
vim.keymap.set('n', '<C-K>', '<C-W><C-K>')
vim.keymap.set('n', '<C-L>', '<C-W><C-L>')

-- Easier resize
vim.keymap.set('', '<s-LEFT>', ':vertical resize +5 <CR>')
vim.keymap.set('', '<s-RIGHT>', ':vertical resize -5 <CR>')
vim.keymap.set('', '<s-UP>', ':resize +5 <CR>')
vim.keymap.set('', '<s-DOWN>', ':resize -5 <CR>')

-- Keep cursor centered when moving by pages.
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

-- When pasting, don't overwrite
-- the register with the deleted text.
-- Sends the deleted text into the void register instead.
vim.keymap.set("x", "<leader>p", "\"_dP")

vim.keymap.set("n", "]c", ":cnext<CR>zz")
vim.keymap.set("n", "[c", ":cprev<CR>zz")
vim.keymap.set("n", "<C-c>", ":cclose<CR>")

vim.keymap.set("n", "]t", ":tabnext<CR>")
vim.keymap.set("n", "[t", ":tabprev<CR>")

vim.keymap.set("i", "jj", "<Esc>")
vim.keymap.set("i", "kk", "<Esc>")
