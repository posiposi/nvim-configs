-- diffview.nvim: Git の差分・ファイル履歴を専用ビューで表示
require('diffview').setup({
  use_icons = true, -- nvim-web-devicons を利用
  enhanced_diff_hl = true, -- 差分ハイライトを見やすく
  view = {
    -- デフォルト（:DiffviewOpen）は 2 ペインの左右分割
    default = { layout = 'diff2_horizontal' },
    -- コンフリクト解決時は base/ours/theirs の 3 ペイン
    merge_tool = { layout = 'diff3_mixed' },
    file_history = { layout = 'diff2_horizontal' },
  },
})
