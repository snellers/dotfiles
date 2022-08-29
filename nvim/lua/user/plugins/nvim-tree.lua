local keymap = require('user.lib.keys').keymap
require('nvim-tree').setup()

keymap('', '<leader>e', ':NvimTreeToggle<CR>', { silent = true, noremap = true })

