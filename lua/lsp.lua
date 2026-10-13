-- Lua: init.lua を書いているこの環境が、最初の実験台
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" }, -- Neovim 内蔵の Lua は LuaJIT
    },
  },
})
-- Go: サーバ名・起動コマンド・目印ファイルを変えるだけで増やせる
vim.lsp.config("gopls", {
  cmd = { "gopls" },
  filetypes = { "go" },
  root_markers = { "go.mod", ".git" },
})

-- PHP: intelephense(無料版。npm i -g intelephense で導入済み)
vim.lsp.config("intelephense", {
  cmd = { "intelephense", "--stdio" },
  filetypes = { "php" },
  root_markers = { "composer.json", ".git" },
  init_options = {
    -- 起動直後のインデックス置き場(既定は一時ディレクトリで再起動のたびに作り直しになる)
    storagePath = vim.fn.stdpath("cache") .. "/intelephense",
  },
  settings = {
    intelephense = {
      telemetry = { enabled = false }, -- 利用状況の送信を止める(nvim-lspconfig の既定に合わせる)
    },
  },
})

-- Laravel: 公式の Laravel LSP(composer global require laravel/lsp で導入)
-- 設定は https://github.com/laravel/lsp の Neovim 節に準拠
vim.lsp.config("laravel_lsp", {
  cmd = { "laravel-lsp" },
  filetypes = { "php", "blade" },
  -- artisan がある(= Laravel アプリの)ときだけ起動する
  root_dir = function(bufnr, on_dir)
    local root = vim.fs.root(bufnr, "artisan")
    if root then
      on_dir(root)
    end
  end,
})

vim.lsp.enable({ "lua_ls", "gopls", "intelephense", "laravel_lsp" })

-- 診断の行内表示は既定オフ(Neovim 0.11 以降)なので明示的に有効化
vim.diagnostic.config({ virtual_text = true })

-- LSP が付いたバッファにだけ効かせる設定
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("my-lsp", { clear = true }),
  callback = function(ev)
    local client = assert(vim.lsp.get_client_by_id(ev.data.client_id))

    -- 補完: サーバが対応していれば、入力に合わせて自動で候補を出す
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf,
        { autotrigger = true })
    end

    -- 保存時フォーマット: サーバが自前で整形しない場合のみ登録する
    if not client:supports_method("textDocument/willSaveWaitUntil")
        and client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = vim.api.nvim_create_augroup("my-lsp-fmt", { clear = false }),
        buffer = ev.buf,
        callback = function()
          vim.lsp.buf.format({
            bufnr = ev.buf,
            id = client.id,
            timeout_ms = 1000
          })
        end,
      })
    end
  end,
})
