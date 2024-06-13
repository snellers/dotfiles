local keymap = require('user.lib.keys').keymap
vim.g.mapleader = ' '
keymap('i', 'jj', '<esc>')
keymap('n', 'o', 'o<esc>')
keymap('n', 'O', 'O<esc>')
keymap('n', 'n', 'nzz')
keymap('n', 'N', 'Nzz')
keymap('n', '<up>', '<nop>')
keymap('n', '<down>', '<nop>')
keymap('n', '<left>', '<nop>')
keymap('n', '<right>', '<nop>')
keymap('n', '<leader>x', ':bd!<CR>')
-- Line moves
keymap('n', '<A-j>', ':m .+1<CR>==')
keymap('n', '<A-k>', ':m .-2<CR>==')
keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi')
keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi')
keymap('x', '<A-j>', ":m '>+1<CR>gv=gv'")
keymap('x', '<A-k>', ":m '<-2<CR>gv=gv'")
-- Copy Paste
keymap('', '<leader>c', '"+y')
keymap('', '<leader>C', '"+yg_')
keymap('', '<leader>v', '"+p')
keymap('', '<leader>V', '"+P')

keymap('n', '<leader>x', ':bd<CR>')

keymap('', '<c-s>', ':w<CR>')
keymap({'v', 'i'}, '<c-s>', '<Esc>:w<CR>')
-- Goto file even if it does not exist
keymap('', 'gf', ':edit <cfile><CR>')
-- Reselect visual selection after indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

keymap('n', '<C-Up>', ':resize +2<CR>')
keymap('n', '<C-Down>', ':resize -2<CR>')
keymap('n', '<C-Left>', ':vertical resize -2<CR>')
keymap('n', '<C-Right>', ':vertical resize +2<CR>')
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
keymap('v', 'y', 'myy`y')
keymap('v', 'Y', 'myY`y')

