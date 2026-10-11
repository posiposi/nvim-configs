vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require('plugins')
require('plugins.mini')
require('plugins.nvim-tree')
require('plugins.lsp')
require('plugins.telescope')
require('plugins.diffview')

require('config.options')
require('config.keymaps')
require('config.autocmds')
require('config.commands')
