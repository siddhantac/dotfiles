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
