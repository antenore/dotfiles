-- $HOME/.vim/init/general.vimrc
vim.g.mapleader = ','
vim.g.maplocalleader = ','
--Let vim automatically load .vimrc found on folders
vim.opt.exrc = true
vim.opt.clipboard = vim.opt.clipboard + "unnamedplus"
vim.opt.regexpengine = 1
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.backspace = "indent,eol,start"
vim.opt.browsedir = "current"
vim.opt.formatoptions = vim.opt.formatoptions + "ro/qj"
-- This makes vim act like all other editors, buffers can
-- exist in the background without being in a window.
-- http://items.sjbach.com/319/configuring-vim-right
vim.opt.hidden = true
vim.opt.history = 2000
vim.opt.ignorecase = true
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.printoptions = "paper:A4,syntax:y"
-- Enable error files & error jumping.
vim.opt.report = 0                         -- tell us when anything is changed via :...
vim.opt.wildmenu = true
-- stuff to ignore when tab completing
vim.opt.wildignore = vim.opt.wildignore + "*.o,*.obj,*~,*.egg-info/**,node_modules/**,dist/**,build/**"
vim.opt.wildmode = "list:longest,full"
-- ignore case (mostly for rediculous camel-cased idioms).
vim.opt.wildignorecase = true
vim.opt.wildchar=('<tab>'):byte()
vim.opt.grepprg = "grep -nH $*"

-- Completion
vim.opt.completeopt = "menu,menuone,noselect"

-- Avoid showing extra messages when using completion
vim.opt.shortmess = vim.opt.shortmess + "c"

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.opt.signcolumn = "yes"

-- Avoid windows have all the same size, this should prevent linter windows to gain space
vim.opt.equalalways = false

-- file extensions to append.
vim.opt.suffixesadd = ".c,.css,.ex,.go,.h,.html,.js,.json,.md,.php,.phpt,.pl,py,.rb,.rs,.scss,.swift,.sh,.xml,.zsh"
