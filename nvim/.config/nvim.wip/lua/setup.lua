-- {{{ ===== Files =============================================================
-- backup directory.
vim.opt.backupdir = vim.fn.expand("$HOME/.cache/nvim")
vim.opt.backup = true

-- swap directory.
vim.opt.directory = vim.fn.expand("$HOME/.cache/nvim")
-- undo directory.
vim.opt.undodir = vim.fn.expand("$HOME/.cache/nvim")
vim.opt.undofile = true
vim.opt.undolevels = 1000
vim.opt.undoreload = 10000

vim.opt.makeef = "error.err"
vim.opt.spellfile = vim.fn.expand("$HOME/Dropbox/vim/spell/en.utf-8.add")
vim.g.netrw_home =  vim.fn.expand("$HOME/.cache") .. '/nvim'
-- CTags
vim.opt.tags = "$HOME/.vim/tags/gtk2,$HOME/.vim/tags/gtk3,$HOME/.vim/tags/glib"
-- }}}

