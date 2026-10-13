-- プラグインの宣言はすべてこのファイルに集める(vim.pack は Neovim 0.12 以降)
vim.pack.add({
  -- ファジーファインダ(telescope)と、その依存(plenary)
  -- vim.pack は依存を解決しないので、依存も自分で並べる
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    version = vim.version.range("0.1"), -- 0.1 系の最新タグに固定
  },
  -- ファイル操作をバッファ編集で行う
  { src = "https://github.com/stevearc/oil.nvim" },
  -- Treesitter の追加パーサ導入係(機能本体は Neovim 組み込み)
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main", -- 現行の開発は main ブランチ(master は凍結済み)
  },
  -- Oil.nvimファイルエクスプローラー用のアイコンセット
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
})

-- カラースキームの適用
vim.cmd.colorscheme("lunaperche")

-- telescope: 第4章と同じ流儀で <leader> 起点のキーマップ
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "ファイル検索" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "grep 検索" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "バッファ一覧" })

-- oil: - で今のファイルの親ディレクトリを開く
require("oil").setup()
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "ファイル操作バッファ" })
