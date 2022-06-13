local auto_group = vim.api.nvim_create_augroup(
    "AutoGroup",
    { clear = true }
    )
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
    group = auto_group,
    pattern = { "*" },
    command = 'if index(excludeft, &ft) <0 | set number'
})
vim.api.nvim_create_autocmd({ 'BufWinLeave', 'WinLeave' }, {
    group = auto_group,
    pattern = { "*" },
    command = 'set nonumber'
})
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    group = auto_group,
    pattern = { "*" },
    command = 'setlocal formatoptions-=t formatoptions-=c'
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = auto_group,
    pattern = { "*" },
    command = ':%s/\\s\\+$//e'
})
vim.api.nvim_create_autocmd({ 'WinEnter' }, {
    group = auto_group,
    pattern = { "*" },
    command = 'setlocal cursorline'
})
vim.api.nvim_create_autocmd({ 'WinEnter' }, {
    group = auto_group,
    pattern = { "*" },
    command = 'setlocal cursorcolumn'
})
vim.api.nvim_create_autocmd({ 'WinLeave' }, {
    group = auto_group,
    pattern = { "*" },
    command = 'setlocal nocursorline'
})
vim.api.nvim_create_autocmd({ 'WinLeave' }, {
    group = auto_group,
    pattern = { "*" },
    command = 'setlocal nocursorcolumn'
})
vim.api.nvim_create_autocmd({ 'BufWinEnter', 'WinEnter' }, {
    group = auto_group,
    pattern = { "*" },
    command = ''
})
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    group = auto_group,
    pattern = { "*i3/config" },
    command = 'setlocal filetype=i3'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = auto_group,
    pattern = { "markdown", "md" },
    command = 'setlocal spell'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = auto_group,
    pattern = { "powershell", "ps1" },
    command = 'set colorcolumn=115'
})


