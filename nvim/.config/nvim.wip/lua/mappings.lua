-- Tabs
vim.api.nvim_set_keymap('n', '<C-S-t>', ':tabnew<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-n>', ':tabn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<C-S-p>', ':tabp<CR>', { noremap = true })

-- way to move between windows
vim.api.nvim_set_keymap('', '<C-j>', '<C-W>j', { noremap = true })
vim.api.nvim_set_keymap('', '<C-k>', '<C-W>k', { noremap = true })
vim.api.nvim_set_keymap('', '<C-h>', '<C-W>h', { noremap = true })
vim.api.nvim_set_keymap('', '<C-l>', '<C-W>l', { noremap = true })

-- Remap ctrl-] to Enter and ctrl-T to Esc to make help sane.
-- local remap_group = vim.api.nvim_create_augroup(
--     "RemapGroup",
--     { clear = true }
--     )
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--     group = remap_group,
--     pattern = "help",
--     command = "nnoremap <buffer> <CR> <C-]>"
-- })
-- vim.api.nvim_create_autocmd({ 'FileType' }, {
--     group = remap_group,
--     pattern = "help",
--     command = 'nnoremap <buffer> <BS> <C-T>'
-- })

-- Remap ctrl-] to Enter and ctrl-T to Esc to make help sane.
local remap_group = vim.api.nvim_create_augroup(
    "RemapGroup",
    { clear = true }
    )
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = remap_group,
    pattern = { 'help' },
    callback = function()
        vim.api.nvim_buf_set_keymap(0, "n", "<CR>", "<C-]>", { noremap = true })
    end
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = remap_group,
    pattern = { 'help' },
    callback = function ()
        vim.api.nvim_buf_set_keymap(0, "n", "<BS>", "<C-T>", { noremap = true })
    end
})

-- Switching buffer mapping
vim.api.nvim_set_keymap('n', '<Leader>1', ':1b<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>2', ':2b<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>3', ':3b<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>4', ':4b<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>5', ':5b<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>6', ':6b<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>7', ':7b<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>8', ':8b<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>9', ':9b<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>0', ':10b<CR>', { noremap = true })

-- Smart resizing
vim.api.nvim_set_keymap('n', '<Up>', ':resize -2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Down>', ':resize +2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Left>', ':vertical resize -2<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Right>', ':vertical resize +2<CR>', { noremap = true })
-- Resizing splits
vim.api.nvim_set_keymap('n', '<Leader>+', ':exe "resize " . (winheight(0) * 3/2)<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>-', ':exe "resize " . (winheight(0) * 2/3)<CR>', { noremap = true, silent = true })

-- Useful functions keys
vim.opt.pastetoggle = '<F12>'

-- for unhighlighing the selections
vim.api.nvim_set_keymap('n', '<Space>x', ":let @/=''<CR>", {noremap = true})

-- Spelling
vim.api.nvim_set_keymap("", "<F5>", ":setlocal spell! spelllang=en_us<CR>", { noremap = true })

-- Buffer navigation
vim.api.nvim_set_keymap('n', '<C-t>', ':GFiles<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader><Enter>', ':<C-u>Buffers<CR>', {noremap = true})
