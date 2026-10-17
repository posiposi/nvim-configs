require("nvim-treesitter").install({ "go", "php", "phpdoc", "blade", "html" })

vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    local ok = pcall(vim.treesitter.start, ev.buf)
    if ok then
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
      vim.wo[0][0].foldlevel = 99
    end
  end,
})
