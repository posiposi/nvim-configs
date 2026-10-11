-- mini.git: カーソル位置の情報を表示
vim.keymap.set({ 'n', 'x' }, '<space>gs', MiniGit.show_at_cursor, { desc = 'Show at cursor' })

-- GitHubパーマリンクをコピー（通常: カーソル行 / Visual: 選択範囲）
vim.keymap.set({ 'n', 'x' }, '<space>gp', ':GhPermalink<CR>', { silent = true, desc = 'Copy GitHub permalink' })

-- diffview: <space>dv で差分ビューをトグル、<space>dh で履歴表示
vim.keymap.set('n', '<space>dv', function()
  if require('diffview.lib').get_current_view() then
    vim.cmd('DiffviewClose')
  else
    vim.cmd('DiffviewOpen')
  end
end, { desc = 'Toggle diffview' })
vim.keymap.set('n', '<space>dh', '<Cmd>DiffviewFileHistory %<CR>', { desc = 'File history (current file)' })
vim.keymap.set('n', '<space>dH', '<Cmd>DiffviewFileHistory<CR>', { desc = 'File history (repository)' })

-- コマンドラインショートハンド: :gsa → :GitStatusAll（先頭で単独入力時のみ展開）
vim.cmd([[cnoreabbrev <expr> gsa (getcmdtype() == ':' && getcmdline() ==# 'gsa') ? 'GitStatusAll' : 'gsa']])

-- LSP: 定義ジャンプ（参照は標準の grr）
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'LSP definition' })

-- 補完ポップアップ表示中は Tab / S-Tab で候補を移動
local imap_expr = function(lhs, rhs)
  vim.keymap.set('i', lhs, rhs, { expr = true })
end
imap_expr('<Tab>',   [[pumvisible() ? "\<C-n>" : "\<Tab>"]])
imap_expr('<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]])

-- d/c/s 系はブラックホールレジスタへ送り、yank を汚さない
for _, key in ipairs({ 'd', 'D', 'c', 'C', 's', 'S' }) do
  vim.keymap.set({ 'n', 'x' }, key, '"_' .. key)
end
-- x を「カット（通常の d）」として扱う
vim.keymap.set({ 'n', 'x' }, 'x', 'd')
vim.keymap.set('n', 'xx', 'dd')
vim.keymap.set('n', 'X', 'D')

-- 検索ハイライト解除 / insert を抜ける
vim.keymap.set('n', '<ESC><ESC>', ':nohlsearch<CR>')
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', { noremap = true, silent = true })

-- ウィンドウ（ペイン）移動: <C-h> 左 / <C-l> 右
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move to left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move to right window' })

-- バッファ移動 / 削除
vim.keymap.set('n', '<S-h>', '<Cmd>bprevious<CR>')
vim.keymap.set('n', '<S-l>', '<Cmd>bnext<CR>')
vim.keymap.set('n', '<S-q>', '<Cmd>Bufdelete<CR>')
