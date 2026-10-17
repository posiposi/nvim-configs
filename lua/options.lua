vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 5
vim.opt.signcolumn = "yes"

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.undofile = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"

vim.opt.statusline = "%f %m%r%=%y %l:%c/%L"

vim.opt.completeopt = { "menuone", "noselect", "popup" }

function _G.BufTabline()
  local s = ""
  local cur = vim.api.nvim_get_current_buf()
  for _, b in ipairs(vim.api.nvim_list_bufs()) do
    if vim.bo[b].buflisted then
      local name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(b), ":t")
      if name == "" then name = "[No Name]" end
      local hl = b == cur and "%#TabLineSel#" or "%#TabLine#"
      local mod = vim.bo[b].modified and " +" or ""
      s = s .. hl .. " " .. name:gsub("%%", "%%%%") .. mod .. " "
    end
  end
  return s .. "%#TabLineFill#"
end
vim.opt.showtabline = 2
vim.opt.tabline = "%!v:lua.BufTabline()"
