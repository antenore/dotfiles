-- {{{ ===== Tagbar =============================================================
vim.g.excludeft = {'tagbar'}
vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true })
-- Open tagbar with supported files
--autocmd VimEnter * nested :call tagbar#autoopen(1)
vim.g.tagbar_ctags_bin = '/usr/local/bin/ctags'
vim.g.tagbar_show_linenumbers = 0
vim.g.tagbar_width = 65
vim.g.tagbar_indent = 1
vim.g.tagbar_autopreview = 0
-- Open Tagbar automatically inside vim
-- autocmd FileType * nested :call tagbar#autoopen(0)
-- Open Tagbar automatically in the current tab
-- autocmd BufEnter * nested :call tagbar#autoopen(0)
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
    group = auto_group,
    pattern = { "*" },
    command = 'if index(excludeft, &ft) <0 | set number'
})
-- }}}
