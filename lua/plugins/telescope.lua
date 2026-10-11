-- telescope.nvim 初期設定（README の基本構成に準拠）
require('telescope').setup({
  defaults = {
    mappings = {
      i = {
        ['<C-h>'] = 'which_key',
      },
    },
  },
  pickers = {},
  extensions = {},
})

-- 推奨キーマップ
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
