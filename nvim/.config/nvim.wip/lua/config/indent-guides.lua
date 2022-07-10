local M = {}
function M.setup()
	local indent_guides = require 'indent_guides'
	indent_guides.setup({
		char = '│',
		indent_level = 10,

		-- treesitter related configuration

		use_treesitter = true,
		show_current_context = true,
		show_trailing_blankline_indent = false,

		show_end_of_line = true,

		--buftype_exclude = {
		--	'nofile',
		--	'terminal',
		--	'alpha',
		--},

		exclude_filetypes = {
			'LspTrouble',
			'Outline',
			'help',
			'norg',
			'packer',
			'startify',
			'dashboard',
			'alpha',
			'markdown',
			'dashpreview',
			'NvimTree',
			'sagaover',
			'vista',
			'',
		},
	})
end

return M
-- END --
