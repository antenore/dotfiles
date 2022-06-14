--
--  ███╗   ██╗  | My init.lua file.
--  ████╗  ██║  | You can use it at your own risk, before to ask question RTFM.
--  ██╔██╗ ██║  | To quit this file type :q
--  ██║╚██╗██║  | WTFPL (The Do What The Fuck You Want To Public License)
--  ██║ ╚████║  | Antenore (tmow) Gatta - WTFPL License
--  ╚═╝  ╚═══╝  | - https://antenore.simbiosi.org
--
-- {{{ ===== Before everything else ============================================
HOME = os.getenv("HOME")
--set nocompatible
vim.opt.foldenable = true
vim.opt.foldmethod = 'marker'
-- }}}
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
-- {{{ ===== Modules ===========================================================
require('plugins')
require('core')
require('latex')
-- }}}
-- {{{ ===== Secrets ===========================================================
--source $HOME/.secrets/.gitlab.vimrc
-- source ~/.gitlabtoken.vimrc
-- }}}
-- {{{ ===== Empty Entry ================================================
-- }}}
-- =============================== EOF =========================================
-- vim:set ts=2 sts=2 sw=2 expandtab:
