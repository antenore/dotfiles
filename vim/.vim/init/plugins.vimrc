"$HOME/.vim/init/plugins.vimrc
if has('nvim')
" {{{ ===== lualine.nvim =======================================================
lua << END
-- Eviline config for lualine
-- Author: shadmansaleh
-- Credit: glepnir
local lualine = require('lualine')

-- Color table for highlights
-- stylua: ignor
local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}

local conditions = {
  buffer_not_empty = function()
    return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
  end,
  hide_in_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand('%:p:h')
    local gitdir = vim.fn.finddir('.git', filepath .. ';')
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Config
local config = {
  options = {
    -- Disable sections and component separators
    component_separators = '',
    section_separators = '',
    -- theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      -- normal = { c = { fg = colors.fg, bg = colors.bg } },
      -- inactive = { c = { fg = colors.fg, bg = colors.bg } },
    -- },
    theme = "tokyobones",
  },
  sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    -- These will be filled later
    lualine_c = {},
    lualine_x = {},
  },
  inactive_sections = {
    -- these are to remove the defaults
    lualine_a = {},
    lualine_b = {},
    lualine_y = {},
    lualine_z = {},
    lualine_c = {},
    lualine_x = {},
  },
}

-- Inserts a component in lualine_c at left section
local function ins_left(component)
  table.insert(config.sections.lualine_c, component)
end

-- Inserts a component in lualine_x ot right section
local function ins_right(component)
  table.insert(config.sections.lualine_x, component)
end

ins_left {
  function()
    return '▊'
  end,
  color = { fg = colors.blue }, -- Sets highlighting of component
  padding = { left = 0, right = 1 }, -- We don't need space before this
}

ins_left {
  -- mode component
  function()
    return ''
  end,
  color = function()
    -- auto change color according to neovims mode
    local mode_color = {
      n = colors.red,
      i = colors.green,
      v = colors.blue,
      [''] = colors.blue,
      V = colors.blue,
      c = colors.magenta,
      no = colors.red,
      s = colors.orange,
      S = colors.orange,
      [''] = colors.orange,
      ic = colors.yellow,
      R = colors.violet,
      Rv = colors.violet,
      cv = colors.red,
      ce = colors.red,
      r = colors.cyan,
      rm = colors.cyan,
      ['r?'] = colors.cyan,
      ['!'] = colors.red,
      t = colors.red,
    }
    return { fg = mode_color[vim.fn.mode()] }
  end,
  padding = { right = 1 },
}

ins_left {
  -- filesize component
  'filesize',
  cond = conditions.buffer_not_empty,
}

ins_left {
  'filename',
  cond = conditions.buffer_not_empty,
  color = { fg = colors.magenta, gui = 'bold' },
}

ins_left { 'location' }

ins_left { 'progress', color = { fg = colors.fg, gui = 'bold' } }

ins_left {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  symbols = { error = ' ', warn = ' ', info = ' ' },
  diagnostics_color = {
    color_error = { fg = colors.red },
    color_warn = { fg = colors.yellow },
    color_info = { fg = colors.cyan },
  },
}

-- Insert mid section. You can make any number of sections in neovim :)
-- for lualine it's any number greater then 2
ins_left {
  function()
    return '%='
  end,
}

ins_left {
  -- Lsp server name .
  function()
    local msg = 'No Active Lsp'
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
        return client.name
      end
    end
    return msg
  end,
  icon = ' LSP:',
  color = { fg = '#ffffff', gui = 'bold' },
}

-- Add components to right sections
ins_right {
  'o:encoding', -- option component same as &encoding in viml
  fmt = string.upper, -- I'm not sure why it's upper case either ;)
  cond = conditions.hide_in_width,
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'fileformat',
  fmt = string.upper,
  icons_enabled = false, -- I think icons are cool but Eviline doesn't have them. sigh
  color = { fg = colors.green, gui = 'bold' },
}

ins_right {
  'branch',
  icon = '',
  color = { fg = colors.violet, gui = 'bold' },
}

ins_right {
  'diff',
  -- Is it me or the symbol for modified us really weird
  symbols = { added = ' ', modified = '柳 ', removed = ' ' },
  diff_color = {
    added = { fg = colors.green },
    modified = { fg = colors.orange },
    removed = { fg = colors.red },
  },
  cond = conditions.hide_in_width,
}

ins_right {
  function()
    return '▊'
  end,
  color = { fg = colors.blue },
  padding = { left = 1 },
}

-- Now don't forget to initialize lualine
lualine.setup(config)
END
" }}}
else
" {{{ ===== Airline ============================================================
" " let g:airline#extensions#tabline#enabled = 1
" " let g:airline#extensions#branch#enabled = 1
" " let g:airline_powerline_fonts = 1 "change 0 to 1 if you have a powerline font
" "let g:airline#extensions#disable_rtp_load = 1
" "let g:airline_theme='Luciano'
" "let g:airline_theme='dracula'
let g:airline_theme='wal'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#ale#enabled = 1
"If things goes nasty
"let g:airline_extensions = []
" }}}
endif
" {{{ ===== ALE ================================================================
"nmap <F8> <Plug>(ale_fix)
"nnoremap <C-F11> <Plug>(ale_fix)
"nnoremap <C-F9> :ALEFix<CR>
" }}}
" {{{ ===== Animates ===========================================================
" Settings for https://github.com/camspiers/animate.vim
" animate is not loaded till the buffer is read, so the following if is useless
"if exists('g:animate#loaded')
"    nnoremap <silent> <Up>    :call animate#window_delta_height(-10)<CR>
"    nnoremap <silent> <Down>  :call animate#window_delta_height(10)<CR>
"    nnoremap <silent> <Left>  :call animate#window_delta_width(-10)<CR>
"    nnoremap <silent> <Right> :call animate#window_delta_width(10)<CR>
"else
"    " disable arrow keys
"    map <up> <nop>
"    map <down> <nop>
"    map <left> <nop>
"    map <right> <nop>
"endif
" }}}
" {{{ ===== Bash Support Plugin ================================================
let g:BASH_MapLeader                = ','
let g:BASH_DoOnNewLine              = 'yes'
let g:BASH_LineEndCommColDefault    = 49
let g:BASH_AuthorName               = 'Antenore Gatta'
let g:BASH_Email                    = 'antenore.gatta@kyndryl.com'
let g:BASH_Company                  = 'Kyndryl Switzerland'
" }}}
" {{{ ===== Deoplete ===========================================================
"let g:deoplete#enable_at_startup = 1
"let g:deoplete#enable_ignore_case = 1
"let g:deoplete#enable_smart_case = 1
"let g:deoplete#enable_camel_case = 1
"let g:deoplete#enable_refresh_always = 1
"let g:deoplete#max_abbr_width = 0
"let g:deoplete#max_menu_width = 0
"let g:deoplete#omni#input_patterns = get(g:,'deoplete#omni#input_patterns',{})
" }}}
" {{{ ===== Devhelp ============================================================
" cp /usr/share/doc/devhelp/devhelp.vim ~/.vim/plugin
let g:devhelpSearch=1
let g:devhelpAssistant=1
let g:devhelpSearchKey = '<S-F5>'
" }}}
" {{{ ===== Doxygen Plugin======================================================
let g:DoxygenToolkit_authorName= 'Antenore Gatta'
let g:DoxygenToolkit_licenseTag= 'Copyright (C) 2014-2022 Antenore Gatta, Giovanni Panozzo\<enter>\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'This program is free software; you can redistribute it and/or modify\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'it under the terms of the GNU General Public License as published by\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'the Free Software Foundation; either version 2 of the License, or\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . '(at your option) any later version.\<enter>\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'This program is distributed in the hope that it will be useful,\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'but WITHOUT ANY WARRANTY; without even the implied warranty of\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'GNU General Public License for more details.\<enter>\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'You should have received a copy of the GNU General Public License\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'along with this program; if not, write to the Free Software\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'Foundation, Inc., 51 Franklin Street, Fifth Floor,\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'Boston, MA  02110-1301, USA.\<enter>\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'In addition, as a special exception, the copyright holders give\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'permission to link the code of portions of this program with the\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'OpenSSL library under certain conditions as described in each\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'individual source file, and distribute linked combinations\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'including the two.\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'You must obey the GNU General Public License in all respects\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'for all of the code used other than OpenSSL.\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'If you modify file(s) with this exception, you may extend this exception\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'to your version of the file(s), but you are not obligated to do so.\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'If you do not wish to do so, delete this exception statement from your\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'version.\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'If you delete this exception statement from all source\<enter>'
let g:DoxygenToolkit_licenseTag = g:DoxygenToolkit_licenseTag . 'files in the program, then also delete it here.\<enter>'
" }}}
" {{{ ===== fugitive / Gitlab===================================================
let g:fugitive_gitlab_domains = ['https://www.gitlab.com']
"source ~/.gitlabtoken.vimrc
" }}}
" {{{ ===== Fuzzy finder =======================================================
" locate command integration
command! -nargs=1 -bang Locate call fzf#run(fzf#wrap(
      \ {'source': 'locate <q-args>', 'options': '-m'}, <bang>0))

" Search lines in all open vim buffers
"(require set hidden to prevent vim unload buffer)
function! s:line_handler(l)
  let l:keys = split(a:l, ':\t')
  exec 'buf' l:keys[0]
  exec l:keys[1]
  normal! ^zz
endfunction

function! s:buffer_lines()
  let l:res = []
  for b in filter(range(1, bufnr('$')), 'buflisted(v:val)')
    call extend(l:res, map(getbufline(b,0,'$'), 'b . ":\t" . (v:key + 1) . ":\t" . v:val '))
  endfor
  return l:res
endfunction

command! FZFLines call fzf#run({
\   'source':  <sid>buffer_lines(),
\   'sink':    function('<sid>line_handler'),
\   'options': '--extended --nth=3..',
\   'down':    '60%'
\})

"Select buffer
function! s:buflist()
  redir => l:ls
  silent ls
  redir END
  return split(l:ls, '\n')
endfunction

function! s:bufopen(e)
  execute 'buffer' matchstr(a:e, '^[ 0-9]*')
endfunction

nnoremap <silent> <Leader><Enter> :call fzf#run({
\   'source':  reverse(<sid>buflist()),
\   'sink':    function('<sid>bufopen'),
\   'options': '+m',
\   'down':    len(<sid>buflist()) + 2
\ })<CR>


" }}}
" {{{ ===== Gutentags ==========================================================
let g:gutentags_ctags_executable='/usr/local/bin/ctags'
" }}}
" {{{ ===== Tagbar =============================================================
let g:excludeft = ['tagbar']
nmap <F8> :TagbarToggle<CR>
" Open tagbar with supported files
"autocmd VimEnter * nested :call tagbar#autoopen(1)
set tags=./tags;,~/.vimtags,~/vim/tags
let g:tagbar_ctags_bin='/usr/local/bin/ctags'
let g:tagbar_show_linenumbers=0
let g:tagbar_width=65
" DO NOT SPECIFY THE CTAGS BINARY. tagbar detect automatically the one to use
" on FreeBSD we use extags (detected)
let g:tagbar_indent=1
let g:tagbar_autopreview=0
" Open Tagbar automatically inside vim
" autocmd FileType * nested :call tagbar#autoopen(0)
" Open Tagbar automatically in the current tab
" autocmd BufEnter * nested :call tagbar#autoopen(0)
" }}}
" {{{ ===== Lens ===============================================================
" https://github.com/camspiers/lens.vim

"The plugin can be disabled completely with:
"let g:lens#disabled = 1

" The plugin can be disabled for specific filetypes:
" let g:lens#disabled_filetypes = ['nerdtree', 'fzf']
" }}}
" {{{ ===== NERDTree ===========================================================
" Open a NERDTree automatically when vim starts up if no files were specified
augroup nerd_open
  autocmd StdinReadPre * let s:std_in=1
  autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
  "Close vim if the only window left open is a NERDTree?
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
augroup END
"Open NERDTree
map <F10> :NERDTreeToggle<CR>
let g:NERDTreeShowLineNumbers=0
" }}}
" {{{ ===== Markdown ===========================================================
" mappings are local to markdown buffers
"
"     <Space> (NORMAL_MODE) switch status of things:
"         Cases
"             A list item * item becomes a check list item * [ ] item
"             A check list item * [ ] item becomes a checked list item * [x] item
"             A checked list item * [x] item becomes a list item * item
"         Can be changed with g:markdown_mapping_switch_status = '<Leader>s
"     <Leader>ft (NORMAL_MODE) format the current table
"     <Leader>e (NORMAL_MODE, VISUAL_MODE) :MarkdownEditCodeBlock edit the current code block in another buffer with a guessed file type. The guess is based on the start of the range for VISUAL_MODE. If it's not possible to guess (you are not in a recognizable code block like a fenced code block) then the default is markdown. If it's not possible to guess and the current range is a single line and the line is empty then a new code block is created. It's asked to the user the file type of the new code block. The default file type is markdown.
"
"let g:markdown_enable_folding = 1
let g:vim_markdown_folding_disabled= 1

" }}}
" {{{ ===== Mini Buffer Explorer ===============================================
" }}}
" {{{ ===== Neomake ============================================================
let g:neomake_javascript_enabled_makers = ['eslint']
" }}}
" {{{ ===== Rust plugins and settings===========================================
let g:racer_cmd = '/home/tmow/.cargo/bin/racer'
let g:racer_experimental_completer = 1
augroup rust_grp
  autocmd!
  autocmd FileType rust nmap gd <Plug>(rust-def)
  autocmd FileType rust nmap gs <Plug>(rust-def-split)
  autocmd FileType rust nmap gx <Plug>(rust-def-vertical)
  autocmd FileType rust nmap <leader>gd <Plug>(rust-doc)
augroup END
" }}}
" {{{ ===== UltiSnip ===========================================================
let g:UltiSnipsExpandTrigger       = "<tab>"
let g:UltiSnipsListSnippets        = "<c-tab>"
let g:UltiSnipsJumpForwardTrigger  = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" }}}
" {{{ ===== VimSafe ============================================================
" Defined in the plugin
"set conceallevel=1
" }}}
" {{{ ===== Grammalecte ========================================================
let g:grammalecte_cli_py='/usr/local/bin/grammalecte-cli.py'
" }}}
" {{{ ===== Pandoc =============================================================
"let g:pandoc#filetypes#handled = ['pandoc', 'markdown']
let g:pandoc#filetypes#pandoc_markdown = 0
" }}}
" {{{ ===== Rainbow Parantheses ================================================
" Disable Rainbow for Nerd Tree
let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle
	let g:rainbow_conf = {
	\	'separately': {
	\		'nerdtree': 0,
	\	}
	\}
" }}}
" {{{ ===== vimtex =============================================================
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
" }}}
if has('nvim')
" {{{ ===== nvim.treesitter ====================================================
lua << END
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "c", "lua", "rust", "vim", "python", "javascript",
                       "java", "ruby", "bash", "go", "json", "yaml", "make",
                       "cmake", "cpp", "dockerfile", "scss", "css", "html",
                       "comment" },

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
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
  indent = {
      enable = true,
  },
}
END
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
" }}}
" {{{ ===== lsp-colors.nvim ====================================================
lua << END
require("lsp-colors").setup({})
END
" }}}
" {{{ ===== telescope-ui-select.nvim ===========================================
lua << END
-- This is your opts table
require("telescope").setup {

  extensions = {
    ["ui-select"] = {

      require("telescope.themes").get_dropdown {
        -- even more opts
      },

    }
  }
}
-- To get ui-select loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("ui-select")
END
" }}}
" {{{ ===== cmp_nvim_ultisnips =================================================
lua << END
require("cmp_nvim_ultisnips").setup {
  filetype_source = "treesitter",
  show_snippets = "all",
  documentation = function(snippet)
    return snippet.description
  end
}
END
" }}}
" {{{ ===== nvim-cmptry ========================================================
lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  require("cmp_nvim_ultisnips").setup{}

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        --vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
        -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
        vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
      end,
    },
    window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
    },
    enabled = function()
      if require "cmp.config.context".in_treesitter_capture("comment") == true or require "cmp.config.context".in_syntax_group("Comment") then
        return false
      else
        return true
      end
    end,
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm{
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      -- { name = 'vsnip' }, -- For vsnip users.
      -- { name = 'luasnip' }, -- For luasnip users.
      { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  -- Setup lspconfig.
  -- local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  -- require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
    -- capabilities = capabilities
  -- }
EOF
" }}}
" {{{ ===== nvim-lsp-installer =================================================
lua << END
require("nvim-lsp-installer").setup({
    automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
    ui = {
        icons = {
            server_installed = "✓",
            server_pending = "➜",
            server_uninstalled = "✗"
        }
    }
})

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.cmake.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
-- It crashes
-- require'lspconfig'.ccls.setup {
--   on_attach = on_attach,
--   capabilities = capabilities,
--   cmd = { "ccls" },
--   init_options = {
--     compilationDatabaseDirectory = "build";
--     index = {
--       threads = 0;
--       };
--     clangd = {
--       excludeArgs = { "-frounding-math"},
--       }
--     }
-- }
require'lspconfig'.jsonls.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require'lspconfig'.puppet.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
-- Ruby
require'lspconfig'.solargraph.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
-- require'lspconfig'.sorbet.setup{
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
-- Lua
require'lspconfig'.sumneko_lua.setup{
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {'vim'},
        },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
        },
      },
    },
}
require'lspconfig'.clangd.setup{
  -- on_attach = on_attach,
  -- capabilities = capabilities
}
require("clangd_extensions").setup{
  -- on_attach = on_attach,
  -- capabilities = capabilities
}
--- require'lspconfig'.tsserver.setup{}
require'lspconfig'.eslint.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require'lspconfig'.tsserver.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require'lspconfig'.vimls.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require'lspconfig'.bashls.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require'lspconfig'.marksman.setup{
  on_attach = on_attach,
  capabilities = capabilities
}
require'lspconfig'.rust_analyzer.setup({
    capabilities=capabilities,
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy diagnostics on save
        checkOnSave = {
          command = "clippy"
        },
      }
    }
})
require('rust-tools').setup({
    capabilities=capabilities,
    on_attach = on_attach
})
-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
END
" }}}
endif
" {{{ ===== Jaflpl.nvim ========================================================
"lua require'jaflpl'.setup({})
" }}}
" {{{ ===== Empty Entry ========================================================
" }}}
