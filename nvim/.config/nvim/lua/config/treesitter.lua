-- {{{ ===== nvim.treesitter ====================================================
require("nvim-treesitter.install").prefer_git = true
require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	-- ensure_installed = "all",  -- or "maintained"
	ensure_installed = { "c", "lua", "rust", "vim", "python", "javascript",
		"ruby", "bash", "json", "yaml", "make", "cmake", "cpp",
		"dockerfile", "scss", "css", "html", "comment"
	},

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "latex" },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		-- disable = { "c", "rust" },
		disable = { "latex" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = { "puppet" }
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection    = "gnn",
			node_incremental  = "grn",
			scope_incremental = "grc",
			node_decremental  = "grm",
		},
	},
	indent = {
		enable = true,
	},
}

-- Puppet (and eventually other languahes)
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.puppet = {
  install_info = {
    url = "https://github.com/awrenn/tree-sitter-puppet",
    branch = "main",
    files = { "src/parser.c", "src/scanner.cc" },
    -- generate_requires_npm = true,
  },
  filetype = "puppet", -- if filetype does not agrees with parser name
  -- used_by = {"bar", "baz"} -- additional filetypes that use this parser
}
-- https://github.com/p00f/nvim-ts-rainbow
require("nvim-treesitter.configs").setup {
  highlight = {
      -- ...
  },
  -- ...
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    -- colors = {}, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim-treesitter#foldexpr()"
-- }}}

