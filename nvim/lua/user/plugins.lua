-- Install packer
local is_bootstrap = false
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  vim.cmd [[packadd packer.nvim]]
end

-- Initialize packer
require('packer').init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'solid' })
    end,
  },
})

-- Install plugins
local use = require('packer').use

use('wbthomason/packer.nvim') -- Let packer manage itself
use('tpope/vim-sensible')
use('tpope/vim-unimpaired')
use('tpope/vim-fugitive')
use('tpope/vim-surround')
use('tpope/vim-endwise')
use('tpope/vim-eunuch')
use('tpope/vim-sleuth')
use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugins.lualine')
  end,
})

use({
  'akinsho/bufferline.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugins.bufferline')
  end,
})

use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('user.plugins.nvim-tree')
  end,
})

use({
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
  config = function()
    require('user.plugins.telescope')
  end,
})

use({
  'Mofiqul/dracula.nvim',
  config = function()
    vim.cmd('colorscheme dracula')
  end,
})

use({
  'sakhnik/nvim-gdb',
  config = function()
    require('user.plugins.nvimgdb')
  end,
})

use({
  'neovim/nvim-lspconfig',
  config = function()
    require('user.plugins.nvim-lspconfig')
  end
})

use({
  'tpope/vim-dadbod',
  cmd = {'DB', 'DBUI', 'DBUIToggle'}
})

use({
  'kristijanhusak/vim-dadbod-ui',
  after = 'vim-dadbod',
  cmd = {'DBUI', 'DBUIToggle'},
  config = function()
    require('user.plugins.dadbod-ui')
  end
})

use({
  'hrsh7th/nvim-cmp',
  requires = {
    'neovim/nvim-lspconfig',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',
    {'kristijanhusak/vim-dadbod-completion', ft = {'sql'}},
  },
  config = function()
    require('user.plugins.cmp')
  end,
})

use({
  'numToStr/Comment.nvim',
  config = function()
    require('Comment').setup()
  end
})

-- Automatically install plugins on first run
if is_bootstrap then
  require('packer').sync()
end

-- Automatically regenerate compiled loader file on save
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

