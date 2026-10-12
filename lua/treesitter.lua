-- 追加パーサの導入対象。同梱パーサ(c / lua / markdown / vim / vimdoc / query)
-- 以外で使う言語をここに並べる。導入済みなら何もしない(毎回走らせてよい)
require("nvim-treesitter").install({ "go" })

-- パーサのあるファイルタイプだけ、ハイライトと折りたたみを有効化する
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    -- パーサが無い filetype では start() がエラーになるため pcall で包む
    local ok = pcall(vim.treesitter.start, ev.buf)
    if ok then
      -- 構文木ベースの折りたたみ(zc / zo が関数・ブロック単位になる)
      vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.wo[0][0].foldmethod = "expr"
      vim.wo[0][0].foldlevel = 99 -- 開いた直後に全部畳まれるのを防ぐ
    end
  end,
})
