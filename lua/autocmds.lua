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
    vim.wo.wrap = true
    vim.wo.linebreak = true
  end,
  desc = "Markdown では単語単位で折り返す",
})

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "php",
  callback = function()
    vim.bo.shiftwidth = 4
    vim.bo.tabstop = 4
    vim.bo.softtabstop = 4
  end,
  desc = "PHP ではインデント幅を4にする",
})
