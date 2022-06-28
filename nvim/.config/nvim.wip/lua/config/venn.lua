-- enable or disable keymappings for venn
function _G.toggle_venn()
	local venn_enabled = vim.inspect(vim.b.venn_enabled)
	if venn_enabled == 'nil' then
		vim.b.venn_enabled = true
		vim.cmd[[setlocal ve=all]]

		-- line
		vim.api.nvim_buf_set_keymap(0, 'n', 'J', '<C-v>j:VBox<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<C-v>k:VBox<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'n', 'L', '<C-v>l:VBox<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'n', 'H', '<C-v>h:VBox<CR>', {noremap = true})

		--box
		vim.api.nvim_buf_set_keymap(0, 'v', '<LocalLeader>f', ':VFill<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'v', '<LocalLeader>s', ':VBox<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'v', '<LocalLeader>d', ':VBoxD<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'v', '<LocalLeader>h', ':VBoxH<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'v', '<LocalLeader>S', ':VBoxO<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'v', '<LocalLeader>D', ':VBoxDO<CR>', {noremap = true})
		vim.api.nvim_buf_set_keymap(0, 'v', '<LocalLeader>H', ':VBoxHO<CR>', {noremap = true})
	else
		vim.cmd[[setlocal ve=]]
		vim.cmd[[mapclear <buffer>]]
		vim.b.venn_enabled = nil
	end
end

-- toggle keymappings for venn using <leader>v
vim.cmd [[ nnoremap <silent> <Leader>v :lua toggle_venn()<CR> ]]
