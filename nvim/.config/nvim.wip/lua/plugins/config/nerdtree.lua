-- {{{ ===== NERDTree ===========================================================
-- Open a NERDTree automatically when vim starts up if no files were specified

local nerd_group = vim.api.nvim_create_augroup(
    "NerdOpenGroup",
    { clear = true }
    )

vim.api.nvim_create_autocmd({'StdinReadPre' }, {
    group = nerd_group,
    pattern = { '*' },
    command = 'let s:std_in=1'
})
vim.api.nvim_create_autocmd( {'VimEnter'}, {
    group = nerd_group,
    pattern = { '*' },
    command = 'if argc() == 0 && !exists("s:std_in") | NERDTree | endif'
})
--Close vim if the only window left open is a NERDTree?
vim.api.nvim_create_autocmd( { 'BufEnter' }, {
    group = nerd_group,
    pattern = { '*' },
    command = 'if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif'
})

-- @param {string} event - event or events to match against
vim.api.nvim_get_autocmds({ event = "FileType" })

--Open NERDTree
vim.api.nvim_set_keymap(
  "",
  "<F10>",
  ":NERDTreeToggle<cr>",
  { noremap = true }
 )
vim.g.NERDTreeShowLineNumbers = 0

-- }}}
