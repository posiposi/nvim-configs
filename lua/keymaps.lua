local map = vim.keymap.set

map("n", "<leader>w", "<cmd>write<CR>", { desc = "保存" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "閉じる" })

map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "検索ハイライト消去" })

map("n", "j", function() return vim.v.count == 0 and "gj" or "j" end,
  { expr = true, desc = "表示行で下へ" })
map("n", "k", function() return vim.v.count == 0 and "gk" or "k" end,
  { expr = true, desc = "表示行で上へ" })

map({ "n", "x" }, "d", '"_d', { desc = "削除(レジスタに残さない)" })

map("n", "H", "<cmd>bprevious<CR>", { desc = "前のバッファ" })
map("n", "L", "<cmd>bnext<CR>", { desc = "次のバッファ" })
map("n", "W", "<cmd>write<CR>", { desc = "バッファを保存" })
map("n", "Q", function()
  local buf = vim.api.nvim_get_current_buf()
  if vim.bo[buf].modified then
    vim.notify("未保存の変更があります(W で保存)", vim.log.levels.WARN)
    return
  end
  vim.cmd("bprevious")
  if vim.api.nvim_get_current_buf() == buf then
    vim.cmd("enew")
  end
  vim.cmd.bdelete(buf)
end, { desc = "バッファを閉じる" })
