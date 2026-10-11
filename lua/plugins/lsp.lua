-- LSP / 診断
vim.lsp.enable('lua_ls')
vim.lsp.enable('gopls')

vim.diagnostic.config({
  virtual_text = true,
})
