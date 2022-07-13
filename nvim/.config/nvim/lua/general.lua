require "utils"

--  ===== let global vars (let g:xx = xxx) =====================================
Variable.g {
	-- this will save almost 20ms
	python3_host_skip_check = 1,
	python3_host_prog       = "/usr/bin/python3",
	-- " enable embeded lua syntax
	-- " see https://github.com/neovim/neovim/pull/14213
	vimsyn_embed            = "l",
	mousehide               = true, --  "hide when characters are typed
}

--  ===== set global options (set xxx = xxx) ==================================

Option.g {
	encoding       = "utf-8",                -- "set encoding for text
	-- Files
	shada          = "!,%,:100,'300,/50,<300,s100,f1,h",
	makeef         = "error.err",
	spellfile      = vim.fn.expand("$HOME/Dropbox/vim/spell/en.utf-8.add"),
	-- Migrated
	-- clipboard   = vim.opt.clipboard + "unnamedplus",
	regexpengine   = 1,
	browsedir      = "current",
	termguicolors  = true,

	-- enable cursorline
	cursorline     = true,
	cursorcolumn   = true,

	undodir        = vim.fn.expand(vim.fn.stdpath "cache" .. "/nvim"),
	undofile       = true,
	undolevels     = 1000,
	undoreload     = 10000,
	cmdheight      = 2,
	laststatus     = 2,
	showmode       = false,
	-- Set completeopt to have a better completion experience
	-- https://github.com/hrsh7th/nvim-cmp#completioncompleteopt-type-string
	completeopt    = "menu,menuone,noselect",
	-- Avoid showing message extra message when using completion
	shortmess      = vim.o.shortmess .. "c",
	list           = true,

	pastetoggle    = '<F12>',

	-- stylua: ignore
	listchars      = "tab:│ ,trail:•,extends:❯,precedes:❮",

	-- " The delay is governed by vim's updatetime option,
	-- " default updatetime 4000ms is not good for async update
	updatetime     = 100,

	-- set signcolumn to 2 to avoid git gutter sign conflict with linter sign
	signcolumn     = "yes:2",

	background     = "dark",

	-- base configuration
	timeoutlen     = 300,                    -- mapping timeout
	ttimeoutlen    = 50,                     -- keycode timeout

	-- mouse       = "a", -- "enable mouse
	history        = 1000,                   -- number of command lines to remember
	ttyfast        = true,                   -- assume fast terminal connection
	viewoptions    = "folds,options,cursor", -- unix and slash are deprecated, do not use
	hidden         = true,                   -- allow buffer switching without saving
	autoread       = true,                   -- auto reload if file saved externally
	fileformats    = "unix,dos,mac",         -- add mac to auto-detection of file format line endings
	-- nrformats   = "bin,hex"
	showcmd        = true,
	-- showfulltag = true,
	modeline       = true,
	modelines      = 5,
	startofline    = false,

	shelltemp      = false,                  -- use pipes
	-- whitespace
	backspace      = "indent,eol,start",     -- " allow backspacing everything in insert mode
	autoindent     = true,                   -- " automatically indent to match adjacent lines
	expandtab      = true,                   -- " spaces instead of tabs
	smarttab       = true,                   -- " use shiftwidth to enter tabs
	tabstop        = 8,                      -- " number of spaces per tab for display
	softtabstop    = 4,                      -- " number of spaces per tab in insert mode
	shiftwidth     = 4,                      -- " number of spaces when indenting
	shiftround     = true,
	linebreak      = true,
	showbreak      = "↪ ",
	wrap           = false,

	-- ruler       = true,
	-- title       = true,

	scrolloff      = 1,                      -- always show content after scroll
	scrolljump     = 5,                      -- minimum number of lines to scroll
	-- display     = "lastline,msgsep",
	wildmenu       = true,                   -- show list for autocomplete
	wildmode       = "list:longest,full",    -- Command-line completion mode
	wildignorecase = true,
	wildchar       = 9,                      -- Like settings <Tab>

	splitbelow     = true,
	splitright     = true,

	-- disable sounds
	errorbells     = false,
	visualbell     = false,

	-- searching
	hlsearch       = true,                   -- "highlight searches
	incsearch      = true,                   -- "incremental searching
	ignorecase     = true,                   -- "ignore case for searching
	smartcase      = true,                   -- "do case-sensitive if there's a capital letter
	smartindent    = true,

	-- backups
	backup         = true,
	backupdir      = vim.fn.expand(vim.fn.stdpath "cache" .. "/nvim"),
	-- no swap files
	swapfile       = false,

	-- ui configuration
	showmatch      = true,                   -- automatically highlight matching braces/brackets/etc.
	matchtime      = 2,                      -- tens of a second to show matching parentheses
	number         = true,
	foldenable     = true,                   -- enable folds by default
	foldmethod     = "indent",               -- do not use syntax as fdm due to performance issue
	foldlevelstart = 99,                     -- open all folds by default

	textwidth      = 0,                      -- Disabled, text is not broken after N columns.
	colorcolumn    = 87,                     -- highlight column after 'textwidth'
	-- colorcolumn = "+86",               -- + - only when textwidth > 0
}

if vim.fn.exists "$TMUX" then
	vim.go.clipboard = "unnamedplus"
else
	vim.go.clipboard = "unnamedplus" --   "sync with OS clipboard
end

if vim.fn.executable "rg" then
	-- With --vimgrep default value for the --color flag changes to 'never'.
	vim.go.grepprg = "rg --no-heading --vimgrep --smart-case --follow"
	vim.go.grepformat = "%f:%l:%c:%m"
end

-- window options
Option.w {}

-- buffer options
Option.b {}

--  ==== keybinds ==============================================================

-- quick navigate between windows
nnoremap { "<C-h>", "<C-w>h" }
nnoremap { "<C-j>", "<C-w>j" }
nnoremap { "<C-k>", "<C-w>k" }
nnoremap { "<C-l>", "<C-w>l" }

-- Smart resizing
nnoremap { '<Up>', ':resize -2<CR>' }
nnoremap { '<Down>', ':resize +2<CR>' }
nnoremap { '<Left>', ':vertical resize -2<CR>' }
nnoremap { '<Right>', ':vertical resize +2<CR>' }
-- Resizing splits
nnoremap { '<Leader>+', ':exe "resize " . (winheight(0) * 3/2)<CR>' }
nnoremap { '<Leader>-', ':exe "resize " . (winheight(0) * 2/3)<CR>' }

-- for unhighlighing the selections
nnoremap { '<Space>x', ":let @/=''<CR>" }

-- Spelling
noremap { "<F5>", ":setlocal spell! spelllang=en_us<CR>" }

-- Buffer navigation
nnoremap { '<leader><Enter>', ':<C-u>Buffers<CR>' }

-- tab shortcuts
map { "<leader>tn", ":tabnew<CR>" }
map { "<leader>tc", ":tabclose<CR>" }

--   " quick switch tab window
-- nnoremap { "<right>", ":tabnext<CR>" }
-- nnoremap { "<left>", ":tabprev<CR>" }
-- Switching buffer mapping
noremap { "<leader>1", ":1b<CR>", silent = true }
noremap { "<leader>2", ":2b<CR>", silent = true }
noremap { "<leader>3", ":3b<CR>", silent = true }
noremap { "<leader>4", ":4b<CR>", silent = true }
noremap { "<leader>5", ":5b<CR>", silent = true }
noremap { "<leader>6", ":6b<CR>", silent = true }
noremap { "<leader>7", ":7b<CR>", silent = true }
noremap { "<leader>8", ":8b<CR>", silent = true }
noremap { "<leader>9", ":9b<CR>", silent = true }
noremap { "<leader>0", ":10b<CR>", silent = true }

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

Augroup {
	SetupCursor = {
		-- disable cursorline when insert/visual mode
		{
			"InsertLeave,WinEnter",
			"*",
			function()
				vim.go.cursorline = true
				vim.go.number = true
			end,
		},
		{
			"InsertEnter,WinLeave",
			"*",
			function()
				vim.go.cursorline = false
				vim.go.number = false
			end,
		},
		-- restore-cursor
		{
			"BufReadPost",
			"*",
			function()
				-- :h restore-cursor or :h last-position-jump
				if vim.fn.line "'\"" >= 1 and vim.fn.line "'\"" <= vim.fn.line "$" and vim.bo.ft ~= "commit" then
					vim.cmd 'normal! g`"'
				end
			end,
		},
	},
	RemoveTrailingWhitespace = {
		{
			-- must use BufWritePre, if use BufWritePost has problem with other formatters (whitespace not got removed)
			"BufWritePre",
			"*",
			function()
				-- https://github.com/cappyzawa/trim.nvim/blob/9959b6638432d4f6674194fab1a3c50c44cdbf08/lua/trim/config.lua#L6
				local patterns = {
					[[%s/\s\+$//e]],
					[[%s/\%u200b\+$//e]],
					-- [[%s/\($\n\s*\)\+\%$//]],
					-- [[%s/\%^\n\+//]],
					-- [[%s/\(\n\n\)\n\+/\1/]],
				}
				-- https://github.com/cappyzawa/trim.nvim/blob/9959b6638432d4f6674194fab1a3c50c44cdbf08/lua/trim/trimmer.lua#L6
				local save = vim.fn.winsaveview()
				for _, v in pairs(patterns) do
					vim.api.nvim_exec(string.format("silent! %s", v), false)
				end
				vim.fn.winrestview(save)
			end,
		},
	},
	SetupTabsListFold = {
		["FileType"] = {
			{
				"css,scss",
				function()
					vim.wo.foldmethod = "marker"
					vim.wo.foldmarker = { "," }
				end,
			},
			{
				"python",
				function()
					vim.wo.foldmethod = "indent"
					vim.api.nvim_exec("normal m`:%s/\\s\\+$//e ``")
					vim.bo.cinwords = "if,elif,else,for,while,try,except,finally,def,class,with"
					vim.bo.expandtab = true -- use spaces for tabs
					vim.bo.shiftwidth = 4
					vim.bo.smartindent = true -- insert indents automatically
					vim.bo.tabstop = 4
					vim.wo.colorcolumn = "80"
				end,
			},
			{
				"markdown",
				function()
					vim.wo.list = false
				end,
			},
			{
				"vim",
				function()
					vim.wo.foldmethod = "indent"
					vim.bo.keywordprg = ":help"
				end,
			},
			-- C
			{
				"c,h",
				function()
					vim.bo.expandtab = false
					vim.bo.tabstop = 8
					vim.bo.softtabstop = 8
					vim.bo.shiftwidth = 8
				end,
			},

			{
				"vim,xml,html,yaml,dockerfile,ruby,puppet",
				function()
					vim.bo.tabstop = 2
					vim.bo.softtabstop = 2
					vim.bo.shiftwidth = 2
				end,
			},
			{
				"ruby",
				function()
					vim.wo.foldmethod = "expr"
				end,
			},
			{
				"lua",
				function()
					vim.bo.expandtab = false
					vim.bo.tabstop = 2
					vim.bo.softtabstop = 2
					vim.bo.shiftwidth = 2
				end,
			},
			{
				"sh",
				function()
					vim.wo.foldmethod = "syntax"
				end,
			},

			-- " in makefiles, don't expand tabs to spaces, since actual tab characters are
			-- " needed, and have indentation at 8 chars to be sure that all indents are tabs
			{
				"make",
				function()
					vim.bo.textwidth = 0
					vim.bo.expandtab = false
					vim.wo.wrap = false
					vim.bo.softtabstop = 0
					vim.bo.tabstop = 4
					vim.bo.shiftwidth = 4
				end,
			},
		},
	},
	CommentString = {
		["FileType"] = {
			{
				"toml",
				function()
					vim.bo.commentstring = "# %s"
				end,
			},
		},
	},
	MiscFileType = {
		["BufNewFile,BufRead"] = {
			{
				".gitconfig",
				function()
					vim.api.nvim_command "setlocal filetype=dosini"
				end,
			},
			{
				"*.{automount,service,socket,target,timer}",
				function()
					vim.api.nvim_command "setlocal filetype=systemd"
				end,
			},
		},
	},
	Misc = {
		["TextYankPost"] = {
			{
				"*",
				function()
					-- Highlight on yank
					vim.highlight.on_yank { higroup = "IncSearch", timeout = 150, on_visual = true }
				end,
			},
		},
	},
}
