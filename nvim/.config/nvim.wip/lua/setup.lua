-- {{{ ===== Files =============================================================
-- backup directory.
-- vim.opt.backupdir = vim.fn.expand("$HOME/.cache/nvim")
-- vim.opt.backup = true

-- swap directory.
-- vim.opt.directory = vim.fn.expand("$HOME/.cache/nvim")
-- undo directory.
-- vim.opt.undodir = vim.fn.expand("$HOME/.cache/nvim")
-- vim.opt.undofile = true
-- vim.opt.undolevels = 1000
-- vim.opt.undoreload = 10000

-- vim.opt.makeef = "error.err"
-- vim.opt.spellfile = vim.fn.expand("$HOME/Dropbox/vim/spell/en.utf-8.add")
-- vim.g.netrw_home =  vim.fn.expand("$HOME/.cache") .. '/nvim'
-- CTags
-- vim.opt.tags = "$HOME/.vim/tags/gtk2,$HOME/.vim/tags/gtk3,$HOME/.vim/tags/glib"
-- }}}
-- $HOME/.vim/init/general.vimrc
local options = {
    --Let vim automatically load .vimrc found on folders
    -- Dangerous exrc            = true,
    -- clipboard       = vim.opt.clipboard + "unnamedplus",
    -- regexpengine    = 1,
    -- autoread        = true,
    -- autowrite       = true,
    -- backspace       = "indent,eol,start",
    browsedir       = "current",
    formatoptions   = vim.opt.formatoptions + "ro/qj",
    -- This makes vim act like all other editors, buffers can
    -- exist in the background without being in a window.
    -- http://items.sjbach.com/319/configuring-vim-right
    hidden         = true,
    history        = 2000,
    ignorecase     = true,
    errorbells     = false,
    visualbell     = false,
    printoptions   = "paper:A4,syntax:y",
    -- Enable error files & error jumping.
    report         = 0,         -- tell us when anything is changed via :...
    wildmenu       = true,
    -- stuff to ignore when tab completing
    wildignore     = vim.opt.wildignore + "*.o,*.obj,*~,*.egg-info/**,node_modules/**,dist/**,build/**",
    wildmode       = "list:longest,full",
    -- ignore case (mostly for rediculous camel-cased idioms).
    wildignorecase = true,
    wildchar       = ('<tab>'):byte(),
    grepprg        = "grep -nH $*",

    -- Completion
    completeopt    = "menu,menuone,noselect",

    -- have a fixed column for the diagnostics to appear in
    -- this removes the jitter when warnings/errors flow in
    signcolumn     = "yes",

    -- Avoid windows have all the same size, this should prevent linter windows to gain space
    equalalways    = false,
}

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append "c"

-- file extensions to append.
vim.opt.suffixesadd:append({".c",
                            ".css",
                            ".ex",
                            ".go",
                            ".h",
                            ".html",
                            ".js",
                            ".json",
                            ".md",
                            ".php",
                            ".phpt",
                            ".pl",
                            ".py",
                            ".rb",
                            ".rs",
                            ".scss",
                            ".sh",
                            ".swift",
                            ".xml",
                            ".zsh"
})
for k, v in pairs(options) do
  vim.opt[k] = v
end

