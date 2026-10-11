-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- OR setup with a config
---@type nvim_tree.config
local config = {
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    git_ignored = false,
  },
}
require("nvim-tree").setup(config)

-- ツリーの表示/非表示トグル
vim.keymap.set("n", "<leader>e", "<Cmd>NvimTreeToggle<CR>")
