-- https://github.com/nvim-telescope/telescope.nvim
--

local actions = require('telescope.actions')
local nf_icons = require('utils.nf-icons')

require('telescope').setup{
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--no-heading',
			'--with-filename',
			'--line-number',
			'--column',
			'--smart-case',
			-- '--color=never',
		},
		-- prompt_prefix = "> ",
		prompt_prefix = nf_icons['pl-left_hard_divider'] .. " ",
		-- selection_caret = "> ",
		selection_caret = nf_icons['pl-left_hard_divider']  .. " ",
		entry_prefix = "  ",
		initial_mode = "insert",
		-- selection_strategy = "reset",
		-- sorting_strategy = "descending",
		-- layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_sorter =  require'telescope.sorters'.get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
		winblend = 0,
		border = {},
		borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
		color_devicons = true,
		use_less = true,
		path_display = {},
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
		grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
		qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker,
		mappings = {
			i = {
				-- ["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous
			},
			n = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous
			},
		}
	},
	extensions = {
		["ui-select"] = {

			require("telescope.themes").get_dropdown {
				-- even more opts
			},
		},
		fzf = {
			fuzzy = true,                    -- false will only do exact matching
			override_generic_sorter = true,  -- override the generic sorter
			override_file_sorter = true,     -- override the file sorter
			case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		}
	},
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
require('telescope').load_extension('ui-select')

-- vim.api.nvim_set_keymap(mode, lhs, rhs, options)
vim.api.nvim_set_keymap('i', '<C-l>', '<CMD>lua require\'telescope.builtin\'.buffers({sort_mru = true, sort_lastused = true})<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-l>', '<CMD>lua require\'telescope.builtin\'.buffers({sort_mru = true, sort_lastused = true})<CR>', { silent = true })

vim.api.nvim_set_keymap('i', '<C-p>', '<CMD>lua require\'telescope.builtin\'.git_files()<CR>', { silent = true })
vim.api.nvim_set_keymap('n', '<C-p>', '<CMD>lua require\'telescope.builtin\'.git_files()<CR>', { silent = true })

-- vim.cmd('command Rg execute "lua require\'telescope.builtin\'.live_grep()"')
-- vim.cmd('command Ag execute "lua require\'telescope.builtin\'.live_grep()"')
vim.cmd('command Ff execute "lua require\'telescope.builtin\'.find_files()<CR>"')
vim.cmd('command Hh execute "lua require\'telescope.builtin\'.help_tags()<CR>"')
vim.cmd('command Bb execute "lua require\'telescope.builtin\'.buffers()<CR>"')
vim.cmd('command Lg execute "lua require\'telescope.builtin\'.live_grep()<CR>"')
vim.cmd('command Lgs execute "lua require\'telescope.builtin\'.grep_string()<CR>"')

-- vim.api.nvim_set_keymap('i', '<leader>fg', '<CMD>lua require\'telescope.builtin\'.live_grep()<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fg', '<CMD>lua require\'telescope.builtin\'.live_grep()<CR>', { silent = true })

-- vim.api.nvim_set_keymap('i', '<leader>fh', '<CMD>lua require\'telescope.builtin\'.man_pages()<CR>', { silent = true })
-- vim.api.nvim_set_keymap('n', '<leader>fh', '<CMD>lua require\'telescope.builtin\'.man_pages()<CR>', { silent = true })

-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
--
-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

