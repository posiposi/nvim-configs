-- mini.nvim 各モジュールのセットアップ
require('mini.icons').setup()
require('mini.basics').setup()
require('mini.statusline').setup()
require('mini.notify').setup()

-- TODO 特定ファイルへの移管検討を行う
local hipatterns = require('mini.hipatterns')
hipatterns.setup({
  highlighters = {
    fixme = { pattern = '%f[%w]()FIXME()%f[%W]', group = 'MiniHipatternsFixme' },
    hack  = { pattern = '%f[%w]()HACK()%f[%W]',  group = 'MiniHipatternsHack'  },
    todo  = { pattern = '%f[%w]()TODO()%f[%W]',  group = 'MiniHipatternsTodo'  },
    note  = { pattern = '%f[%w]()NOTE()%f[%W]',  group = 'MiniHipatternsNote'  },
    hex_color = hipatterns.gen_highlighter.hex_color(),
  },
})

require('mini.cursorword').setup()
require('mini.trailspace').setup()
require('mini.starter').setup()
require('mini.pairs').setup()
-- TODO 別の補完プラグインも検討する
require('mini.completion').setup()
-- TODO barbar.nvim導入後に削除する
require('mini.tabline').setup()
require('mini.bufremove').setup()
-- TODO diffviewへ移行する
require('mini.diff').setup()
require('mini.git').setup()

vim.notify = require('mini.notify').make_notify({})
vim.cmd.colorscheme('vim')
