vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  {
    src = "https://github.com/nvim-telescope/telescope.nvim",
    version = vim.version.range("0.1"),
  },
  { src = "https://github.com/stevearc/oil.nvim" },
  {
    src = "https://github.com/nvim-treesitter/nvim-treesitter",
    version = "main",
  },
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = "https://github.com/lewis6991/gitsigns.nvim" },
})

vim.cmd.colorscheme("lunaperche")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "ファイル検索" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "grep 検索" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "バッファ一覧" })

require("oil").setup({
  view_options = {
    show_hidden = true,
  },
})
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "ファイル操作バッファ" })

require("gitsigns").setup()
