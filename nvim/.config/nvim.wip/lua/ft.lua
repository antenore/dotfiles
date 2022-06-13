-- NB: Auto ommands specific to a plugins go in the plugin settings.

-- vim
local vim_group = vim.api.nvim_create_augroup(
    "VimGroup",
    { clear = true }
    )
vim.api.nvim_create_autocmd({ 'BufRead' }, {
    group =vim_group,
    pattern = { '*.vim', '*.vimrc' },
    command = 'set cindent ts=2 sts=2 et sw=2'
})
-- C
local c_group = vim.api.nvim_create_augroup(
    "cGroup",
    { clear = true }
    )
vim.api.nvim_create_autocmd({ 'BufRead' }, {
    group = c_group,
    pattern = { '*.c', '*.h' },
    command = 'set cindent ts=8 sts=8 sw=8 noexpandtab'
})

-- Python
local python_group = vim.api.nvim_create_augroup(
    "PythonGroup",
    { clear = true }
    )
vim.api.nvim_create_autocmd({ 'BufRead' }, {
    group = python_group,
    pattern = { "*.py" },
    command = 'set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class'
})
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = python_group,
    pattern = { "*.py" },
    command = 'normal m`:%s/\\s\\+$//e ``'
})


-- Ruby
local ruby_group = vim.api.nvim_create_augroup(
    "RubyGroup",
    { clear = true }
    )
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = ruby_group,
    pattern = { "ruby" },
    command = 'set ts=2 sts=2 et sw=2'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = ruby_group,
    pattern = { "rb" },
    command = 'set foldmethod=expr'
})

-- Bash
local bash_group = vim.api.nvim_create_augroup(
    "BashGroup",
    { clear = true }
    )
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = bash_group,
    pattern = { "sh" },
    command = 'let g:is_bash=1'
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = bash_group,
    pattern = { "sh" },
    command = 'set foldmethod=syntax'
})
