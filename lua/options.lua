-- 表示
vim.opt.number = true -- 行番号
vim.opt.relativenumber = true -- 相対行番号
vim.opt.scrolloff = 5 -- カーソル上下に常に5つの歯科医を確保
vim.opt.signcolumn = "yes" --LSP導入後の表示ガタつきを防ぐ

-- インデント
vim.opt.expandtab = true -- Tabキーで空白を入れる
vim.opt.shiftwidth = 2 -- >> や = のインデント幅
vim.opt.tabstop = 2 -- 既存のタブ文字の表示幅

-- 検索
vim.opt.ignorecase = true -- 小文字だけなら大文字小文字を無視
vim.opt.smartcase = true -- 大文字を含めたら区別に切り替える

-- 編集の下支え
vim.opt.undofile = true -- ファイルを閉じてもアンドゥ履歴を保持
vim.opt.splitright = true -- 縦分割は右に開く
vim.opt.splitbelow = true -- 横分割は下に開く
vim.opt.clipboard = "unnamedplus" -- 無名レジスタをOSクリップボードと共有

-- ステータスライン(プラグインなしの最小カスタム。第5章)
vim.opt.statusline = "%f %m%r%=%y %l:%c/%L"

-- 補完メニュー(第6章): 候補を自動選択せず、ドキュメントをポップアップ表示
vim.opt.completeopt = { "menuone", "noselect", "popup" }
