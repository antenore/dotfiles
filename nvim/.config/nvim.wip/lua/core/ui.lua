--$HOME/.vim/init/ui.vimrc
--
-- All the settings related to the UI goes here
--
-- ==============================================================================

-- {{{ ===== Colorschemes =======================================================
-- This option doesn't play well with most themes.

--colorscheme nord
--colorscheme Luciano
--colorscheme wal
--colorscheme preto

--zenbones
--colorscheme zenbones
--colorscheme zenwritten
--colorscheme neobones
--colorscheme vimbones
--colorscheme rosebones
--colorscheme forestbones
--colorscheme nordbones
--colorscheme seoulbones
--colorscheme duckbones
--colorscheme zenburned
--colorscheme kanagawabones
--colorscheme randombones
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.cmd('colorscheme tokyobones')


-- }}}
-- {{{ ===== Tabs ===============================================================
vim.opt.tabpagemax = 15
vim.opt.showtabline = 2
-- }}}
-- {{{ ===== Visual Cues ========================================================
-- Highlight if more then 87 chars
vim.opt.colorcolumn = { 87 }
--highlight ColorColumn term=reverse cterm=reverse
--highlight CursorLine term=underline cterm=underline gui=underline
--highlight CursorLine guibg=#303000 ctermbg = 234
--highlight CursorColumn guibg=#303000 ctermbg = 234

vim.opt.cmdheight = 2
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.laststatus = 2                             -- always show the status line
vim.opt.list = true
vim.opt.listchars:append("tab:» ")
vim.opt.listchars:append("trail:•")
vim.opt.listchars:append("extends:#")
vim.opt.listchars:append("nbsp:.")
vim.opt.showmatch = true                           -- show matching brackets
vim.opt.matchtime = 5                              -- Tenths of a second to show the matching paren (showmatch)
vim.opt.modeline = true                            -- in source settings --> # vim: tabstop = 8 expandtab shiftwidth = 4 softtabstop = 4
vim.opt.startofline = false                        -- keep the cursor in the same colon when changing line
vim.opt.number = true
vim.opt.scrolloff = 3
vim.opt.ruler = true
vim.opt.showcmd = true
vim.opt.showmatch = true                           -- show matching brackets
vim.opt.sidescroll = 1
vim.opt.sidescrolloff = 10
vim.opt.smartcase = true
vim.opt.scrolloff = 10                               -- Keep 10 lines (top/bottom) for scope
vim.opt.title = true
-- }}}
-- vim:set ts=2 sts=2 sw=2 expandtab:
