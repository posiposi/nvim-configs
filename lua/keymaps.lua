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
