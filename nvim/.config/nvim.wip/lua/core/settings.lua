-- $HOME/.vim/init/general.vimrc
vim.g.mapleader = ','
vim.g.maplocalleader = ','
local options = {
    --Let vim automatically load .vimrc found on folders
    exrc = true,
    clipboard = vim.opt.clipboard + "unnamedplus",
    regexpengine = 1,
    autoread = true,
    autowrite = true,
    backspace = "indent,eol,start",
    browsedir = "current",
    formatoptions = vim.opt.formatoptions + "ro/qj",
    -- This makes vim act like all other editors, buffers can
    -- exist in the background without being in a window.
    -- http://items.sjbach.com/319/configuring-vim-right
    hidden = true,
    history = 2000,
    ignorecase = true,
    errorbells = false,
    visualbell = false,
    printoptions = "paper:A4,syntax:y",
    -- Enable error files & error jumping.
    report = 0,                        -- tell us when anything is changed via :...
    wildmenu = true,
    -- stuff to ignore when tab completing
    wildignore = vim.opt.wildignore + "*.o,*.obj,*~,*.egg-info/**,node_modules/**,dist/**,build/**",
    wildmode = "list:longest,full",
    -- ignore case (mostly for rediculous camel-cased idioms).
    wildignorecase = true,
    wildchar=('<tab>'):byte(),
    grepprg = "grep -nH $*",

    -- Completion
    completeopt = "menu,menuone,noselect",

    -- have a fixed column for the diagnostics to appear in
    -- this removes the jitter when warnings/errors flow in
    signcolumn = "yes",

    -- Avoid windows have all the same size, this should prevent linter windows to gain space
    equalalways = false,

    -- file extensions to append.
    suffixesadd = ".c,.css,.ex,.go,.h,.html,.js,.json,.md,.php,.phpt,.pl,py,.rb,.rs,.scss,.swift,.sh,.xml,.zsh",
}

-- Avoid showing extra messages when using completion
vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end
