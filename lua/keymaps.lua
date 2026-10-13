local map = vim.keymap.set

-- ホームポジションから保存・終了(:w :q のコロン移動を省く)
map("n", "<leader>w", "<cmd>write<CR>", { desc = "保存" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "閉じる" })

-- 検索ハイライトを ESC で消す(CTRL-L と同じ働きを馴染みのキーに)
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "検索ハイライト消去" })

-- 折り返し行を見た目どおり上下移動(第2章の gj/gk を既定に)
-- カウント付き(5j など)は行移動のまま、相対行番号と一致させる
map("n", "j", function() return vim.v.count == 0 and "gj" or "j" end,
  { expr = true, desc = "表示行で下へ" })
map("n", "k", function() return vim.v.count == 0 and "gk" or "k" end,
  { expr = true, desc = "表示行で上へ" })

-- d による削除は、削除した文字をレジスタ(=クリップボード)に残さない
map({ "n", "x" }, "d", '"_d', { desc = "削除(レジスタに残さない)" })

-- バッファ操作(タブラインに並ぶバッファを切り替える)
-- H/L/W/Q の既定動作(画面上端/下端へ移動、WORD 移動、マクロ再実行)は上書きする
map("n", "H", "<cmd>bprevious<CR>", { desc = "前のバッファ" })
map("n", "L", "<cmd>bnext<CR>", { desc = "次のバッファ" })
map("n", "W", "<cmd>write<CR>", { desc = "バッファを保存" })
map("n", "Q", function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].modified then
    vim.notify("未保存の変更があります(W で保存)", vim.log.levels.WARN)
    return
  end
  -- ウィンドウを閉じずに済むよう、先に別のバッファへ切り替えてから削除する
  vim.cmd("bprevious")
  if vim.api.nvim_get_current_buf() == buf then
    vim.cmd("enew") -- 最後の1つなら空バッファを用意する
  end
  vim.cmd.bdelete(buf)
end, { desc = "バッファを閉じる" })
