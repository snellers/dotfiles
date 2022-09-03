local keymap = require('user.lib.keys').keymap

local opts = {silent = true}
keymap('n', '<leader>db', [[<cmd>DBUIToggle<cr>]], opts)

vim.g.db_ui_use_nerd_fonts = 1
vim.g.db_ui_show_database_icon = 1
