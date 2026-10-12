-- 再読み込みしても二重登録されないよう、グループを作って毎回クリアする
local group = vim.api.nvim_create_augroup("my-config", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  group = group,
  callback = function() vim.hl.on_yank() end,
  desc = "ヤンクした範囲を一瞬ハイライトする",
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "markdown",
  callback = function()
    -- 散文は論理行が長いので、折り返しを単語境界にする
    vim.wo.wrap = true
    vim.wo.linebreak = true
  end,
  desc = "Markdown では単語単位で折り返す",
})
