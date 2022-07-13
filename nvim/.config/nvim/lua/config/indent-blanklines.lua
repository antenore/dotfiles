local M = {}
function M.setup()
	vim.g.indent_blankline_char = "│"
	vim.g.indent_blankline_show_first_indent_level = true
	vim.g.indent_blankline_filetype_exclude = {
		"alpha",
		"startify",
		"dashboard",
		"log",
		"packer",
		"markdown",
		"txt",
		"vista",
		"help",
		"NvimTree",
		"TelescopePrompt",
		"" -- for all buffers without a file type
	}
	vim.g.indent_blankline_buftype_exclude = {"terminal", "nofile"}
	vim.g.indent_blankline_show_trailing_blankline_indent = false
	vim.g.indent_blankline_show_current_context = true
	--[[
	vim.g.indent_blankline_context_patterns = {
		"class",
		"function",
		"method",
		"block",
		"list_literal",
		"selector",
		"^if",
		"^table",
		"if_statement",
		"while",
		"for",
		"case"
	}
	--]]
	-- because lazy load indent-blankline so need readd this autocmd
	vim.cmd("autocmd CursorMoved * IndentBlanklineRefresh")
end

return M
-- END --
