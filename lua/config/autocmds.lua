-- insert を抜けたら IME を英数（macism）に戻す
local macism = '/opt/homebrew/bin/macism'
vim.api.nvim_create_autocmd('InsertLeave', {
  pattern = '*',
  callback = function()
    vim.system({ macism, 'com.google.inputmethod.Japanese.Roman' })
  end,
})
