-- {{{ ===== Markdown ===========================================================
-- mappings are local to markdown buffers
--
--     <Space> (NORMAL_MODE) switch status of things:
--         Cases
--             A list item * item becomes a check list item * [ ] item
--             A check list item * [ ] item becomes a checked list item * [x] item
--             A checked list item * [x] item becomes a list item * item
--         Can be changed with g:markdown_mapping_switch_status = '<Leader>s
--     <Leader>ft (NORMAL_MODE) format the current table
--     <Leader>e (NORMAL_MODE, VISUAL_MODE) :MarkdownEditCodeBlock edit the current code block in another buffer with a guessed file type. The guess is based on the start of the range for VISUAL_MODE. If it's not possible to guess (you are not in a recognizable code block like a fenced code block) then the default is markdown. If it's not possible to guess and the current range is a single line and the line is empty then a new code block is created. It's asked to the user the file type of the new code block. The default file type is markdown.
--
--let g:markdown_enable_folding = 1
vim.g.vim_markdown_folding_disabled= 1

-- }}}
