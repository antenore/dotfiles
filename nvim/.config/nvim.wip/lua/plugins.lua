local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local use = require('packer').use
require('packer').startup(function()
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    use 'rktjmp/lush.nvim'
    use {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end
    }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = function()
            require("plugins.config.lualine")
        end
    }
    use 'folke/lsp-colors.nvim'                        -- Auto add missing colour group for LSP
    use 'williamboman/nvim-lsp-installer'
    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/lsp_extensions.nvim'                 -- Extentions to built-in LSP, for example, providing type inlay hints
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            "quangnguyen30192/cmp-nvim-ultisnips",
            "nvim-treesitter/nvim-treesitter",
        },
    }
    use 'p00f/clangd_extensions.nvim'
    use 'quangnguyen30192/cmp-nvim-ultisnips'
    use 'cuducos/yaml.nvim'
    use 'nvim-lua/plenary.nvim'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use 'nvim-telescope/telescope-ui-select.nvim'

    -- Vim/Neovim plugins
    use {
        'junegunn/fzf.vim',
        requires = {'junegunn/fzf'},
        run = function() vim.fn["fzf#install"]() end
    }
    -- use 'antenore/vim-safe'                         -- Not compatible with neovim
    use 'chrisbra/csv.vim'
    use 'ludovicchabant/vim-gutentags'
    use 'majutsushi/tagbar'
    use 'godlygeek/tabular'                            -- Needed by vim-markdown (and me :- )
    use 'SirVer/ultisnips'
    use 'honza/vim-snippets'                           -- ultisnip, snipmate and neosnippet
    use 'mboughaba/i3config.vim'
    use 'nvie/vim-flake8'                              -- Python style guide
    use 'relastle/vim-nayvy'                           -- Enriching python coding.
    use 'plasticboy/vim-markdown'                      -- Needs tabular
    use 'rodjek/vim-puppet'
    use 'puppetlabs/puppet-syntax-vim'
    use 'scrooloose/nerdtree'
    use 'tpope/vim-fugitive'                           -- :G*
    use 'shumphrey/fugitive-gitlab.vim'                -- :Gbrowse
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-surround'
    use 'tmux-plugins/vim-tmux'
    use 'wincent/command-t'
    use 'ryanoasis/vim-devicons'
    use 'PProvost/vim-ps1'
    use 'https://gitlab.com/antenore/Luciano.git'      -- Hey it's me!!
    use '/home/antenore/software/myvim/plugins/mdview.nvim'
    -- use '/home/antenore/software/myvim/plugins/jaflpl.nvim'
    use 'mcchrish/zenbones.nvim'
    use 'ewilazarus/preto'
    use 'luochen1990/rainbow'
    use 'lervag/vimtex'
    use { 'neomake/neomake', cmd = 'Neomake' }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)

-- {{{ ===== fugitive / Gitlab===================================================
vim.g.fugitive_gitlab_domains = { 'https://www.gitlab.com' }
--source ~/.gitlabtoken.vimrc
-- }}}
-- {{{ ===== Fuzzy finder =======================================================
-- locate command integration
vim.api.nvim_exec([[
command! -nargs=1 -bang Locate call fzf#run(fzf#wrap(
      \ {'source': 'locate <q-args>', 'options': '-m'}, <bang>0))

" Search lines in all open vim buffers
" require set hidden to prevent vim unload buffer)
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
]], true)


-- }}}
-- {{{ ===== Gutentags ==========================================================
vim.g.gutentags_ctags_executable = '/usr/local/bin/ctags'
-- }}}
-- {{{ ===== Tagbar =============================================================
vim.g.excludeft = {'tagbar'}
vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true })
-- Open tagbar with supported files
--autocmd VimEnter * nested :call tagbar#autoopen(1)
vim.g.tagbar_ctags_bin = '/usr/local/bin/ctags'
vim.g.tagbar_show_linenumbers = 0
vim.g.tagbar_width = 65
-- DO NOT SPECIFY THE CTAGS BINARY. tagbar detect automatically the one to use
-- on FreeBSD we use extags (detected)
vim.g.tagbar_indent = 1
vim.g.tagbar_autopreview = 0
-- Open Tagbar automatically inside vim
-- autocmd FileType * nested :call tagbar#autoopen(0)
-- Open Tagbar automatically in the current tab
-- autocmd BufEnter * nested :call tagbar#autoopen(0)
-- }}}
-- {{{ ===== NERDTree ===========================================================
-- Open a NERDTree automatically when vim starts up if no files were specified

local nerd_group = vim.api.nvim_create_augroup(
    "NerdOpenGroup",
    { clear = true }
    )

vim.api.nvim_create_autocmd({'StdinReadPre' }, {
    group = nerd_group,
    pattern = { '*' },
    command = 'let s:std_in=1'
})
vim.api.nvim_create_autocmd( {'VimEnter'}, {
    group = nerd_group,
    pattern = { '*' },
    command = 'if argc() == 0 && !exists("s:std_in") | NERDTree | endif'
})
--Close vim if the only window left open is a NERDTree?
vim.api.nvim_create_autocmd( { 'BufEnter' }, {
    group = nerd_group,
    pattern = { '*' },
    command = 'if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif'
})

-- @param {string} event - event or events to match against
vim.api.nvim_get_autocmds({ event = "FileType" })

--Open NERDTree
vim.api.nvim_set_keymap(
  "",
  "<F10>",
  ":NERDTreeToggle<cr>",
  { noremap = true }
 )
vim.g.NERDTreeShowLineNumbers = 0

-- }}}
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
-- {{{ ===== Mini Buffer Explorer ===============================================
-- }}}
-- {{{ ===== Neomake ============================================================
vim.g.neomake_javascript_enabled_makers = {'eslint'}
-- }}}
-- {{{ ===== UltiSnip ===========================================================
vim.g.UltiSnipsExpandTrigger       = "<tab>"
vim.g.UltiSnipsListSnippets        = "<c-tab>"
vim.g.UltiSnipsJumpForwardTrigger  = "<c-j>"
vim.g.UltiSnipsJumpBackwardTrigger = "<c-k>"
-- }}}
-- {{{ ===== VimSafe ============================================================
-- Defined in the plugin
--set conceallevel=1
-- }}}
-- {{{ ===== Grammalecte ========================================================
vim.g.grammalecte_cli_py='/usr/local/bin/grammalecte-cli.py'
-- }}}
-- {{{ ===== Rainbow Parantheses ================================================
-- Disable Rainbow for Nerd Tree
vim.g.rainbow_active = 1 -- set to 0 if you want to enable it later via :RainbowToggle
vim.g.rainbow_conf = {
	separately = {
		nerdtree = 0
	}
}
-- }}}
-- {{{ ===== vimtex =============================================================
vim.g.tex_flavor='latex'
vim.g.vimtex_view_method='zathura'
vim.g.vimtex_quickfix_mode=0
vim.opt.conceallevel = 1
vim.g.tex_conceal='abdmg'
-- }}}
-- {{{ ===== nvim.treesitter ====================================================
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
-- vim.opt.foldmethod = "expr"
-- vim.opt.foldexpr = "nvim-treesitter#foldexpr()"
-- }}}
-- {{{ ===== lsp-colors.nvim ====================================================
require("lsp-colors").setup({})
-- }}}
-- {{{ ===== telescope-ui-select.nvim ===========================================
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
-- }}}
-- {{{ ===== cmp_nvim_ultisnips =================================================
require("cmp_nvim_ultisnips").setup {
  filetype_source = "treesitter",
  show_snippets = "all",
  documentation = function(snippet)
    return snippet.description
  end
}
-- }}}
-- {{{ ===== nvim-cmp ===========================================================
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
-- }}}
-- {{{ ===== nvim-lsp-installer =================================================
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
-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
-- }}}
-- {{{ ===== Jaflpl.nvim ========================================================
-- require'jaflpl'.setup({})
-- }}}
-- {{{ ===== Empty Entry ========================================================
-- }}}
