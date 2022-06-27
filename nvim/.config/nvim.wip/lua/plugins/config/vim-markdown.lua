local M = {}

M.dart = function()
  vim.cmd 'let dart_html_in_string=v:true'
end

M.markdown = function()
  vim.g.vim_markdown_folding_disabled = true
  vim.g.vim_markdown_strikethrough = true
  vim.g.vim_markdown_new_list_item_indent = 2
  vim.g.vim_markdown_no_extensions_in_markdown = 1
  vim.g.vim_markdown_autowrite = 1
  vim.g.vim_markdown_new_list_item_indent = 0
  vim.g.vim_markdown_toc_autofit = 1
    vim.g.vim_markdown_frontmatter = 1 -- for YAML format
    vim.g.vim_markdown_toml_frontmatter = 1 -- for TOML format
    vim.g.vim_markdown_json_frontmatter = 1 -- for JSON format
  vim.g.vim_markdown_fenced_languages = {
    'lua',
    'json',
    'typescript',
    'javascript',
    'js=javascript',
    'ts=typescript',
    'shell=sh',
    'python',
    'sh',
    'puppet',
    'ruby',
    'console=sh',
  }
end

return M
