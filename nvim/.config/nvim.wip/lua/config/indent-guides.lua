require("indent_guides").setup {
	-- default configuration

	char = '│',
	indent_level = 10,
	viewport_buffer = 30,

	-- treesitter related configuration

	use_treesitter = true,
	show_current_context = true,
	show_trailing_blankline_indent = false,

	show_end_of_line = true,

	buftype_exclude = {
		'nofile',
		'terminal',
	},

	filetype_exclude = {
		'LspTrouble',
		'Outline',
		'help',
		'norg',
		'packer',
		'startify',
		'markdown',
	},

}
