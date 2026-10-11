vim.api.nvim_create_user_command(
  'Trim',
  function()
    MiniTrailspace.trim()
  end,
  { desc = 'Trim trailing space and last blank lines' }
)
vim.api.nvim_create_user_command(
  'Bufdelete',
  function()
    MiniBufremove.delete()
  end,
  { desc = 'Remove buffer' }
)
vim.api.nvim_create_user_command(
  'Files',
  function()
    MiniFiles.open()
  end,
  { desc = 'Open file explorer' }
)
vim.api.nvim_create_user_command(
  'GhPermalink',
  function(opts)
    local file = vim.fn.expand('%:p')
    if file == '' then
      vim.notify('ファイルが開かれていません', vim.log.levels.WARN)
      return
    end
    local dir = vim.fn.fnamemodify(file, ':h')

    local function git(cmd)
      local out = vim.fn.systemlist('git -C ' .. vim.fn.shellescape(dir) .. ' ' .. cmd)
      if vim.v.shell_error ~= 0 then return nil end
      return out[1]
    end

    local root = git('rev-parse --show-toplevel')
    if not root then
      vim.notify('git リポジトリではありません', vim.log.levels.WARN)
      return
    end

    local sha    = git('rev-parse HEAD')
    local remote = git('remote get-url origin')
    if not remote then
      vim.notify('origin リモートがありません', vim.log.levels.WARN)
      return
    end

    -- リモートURLをhttps形式へ正規化
    remote = remote:gsub('%.git$', '')
    remote = remote:gsub('^git@([^:]+):', 'https://%1/') -- git@github.com:owner/repo
    remote = remote:gsub('^ssh://git@', 'https://')      -- ssh://git@github.com/owner/repo

    -- リポジトリルートからの相対パス
    local relpath = file:sub(#root + 2)

    -- 行アンカー（範囲選択時はL{start}-L{end}）
    local anchor = '#L' .. opts.line1
    if opts.line2 > opts.line1 then
      anchor = anchor .. '-L' .. opts.line2
    end

    local url = remote .. '/blob/' .. sha .. '/' .. relpath .. anchor
    vim.fn.setreg('+', url) -- システムクリップボード
    vim.notify(url)
  end,
  { range = true, desc = 'Copy GitHub permalink of current/selected lines' }
)
vim.api.nvim_create_user_command(
  'GitStatusAll',
  function(opts)
    local base = vim.fn.getcwd()

    -- 引数があればそれを起点にする（相対なら cwd 基準）
    local root = base
    if opts.args ~= '' then
      root = opts.args:sub(1, 1) == '/' and opts.args or (base .. '/' .. opts.args)
      root = vim.fn.fnamemodify(root, ':p'):gsub('/$', '')
      if vim.fn.isdirectory(root) ~= 1 then
        vim.notify('ディレクトリが見つかりません: ' .. root, vim.log.levels.ERROR)
        return
      end
    end

    -- root 自身と直下から Git リポジトリを集める
    local repos = {}
    if vim.fn.isdirectory(root .. '/.git') == 1 then
      table.insert(repos, root)
    end
    for _, name in ipairs(vim.fn.readdir(root)) do
      local dir = root .. '/' .. name
      if vim.fn.isdirectory(dir .. '/.git') == 1 then
        table.insert(repos, dir)
      end
    end

    -- 各リポジトリで git status を集約
    local items = {}
    for _, repo in ipairs(repos) do
      local label = vim.fn.fnamemodify(repo, ':t')
      local out = vim.fn.systemlist(
        { 'git', '-C', repo, '-c', 'core.quotepath=false', 'status', '--porcelain' }
      )
      if vim.v.shell_error == 0 then
        for _, line in ipairs(out) do
          local status = line:sub(1, 2)
          local path   = line:sub(4):gsub('^.* %-> ', '') -- rename は new を採用
          table.insert(items, {
            filename = repo .. '/' .. path,
            text     = string.format('[%s] %s', label, status),
          })
        end
      end
    end

    if #items == 0 then
      vim.notify('変更されたファイルはありません', vim.log.levels.INFO)
      return
    end

    vim.fn.setqflist({}, ' ', { title = 'Git status: ' .. root, items = items })
    vim.cmd('copen')
  end,
  {
    nargs = '?',
    complete = function(arglead)
      local base = vim.fn.getcwd()
      local res = {}
      for _, name in ipairs(vim.fn.readdir(base)) do
        if vim.fn.isdirectory(base .. '/' .. name .. '/.git') == 1
          and name:find('^' .. vim.pesc(arglead)) then
          table.insert(res, name)
        end
      end
      return res
    end,
    desc = 'Show git status across repos under cwd (or given dir)',
  }
)
