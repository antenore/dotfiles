require "utils"

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    }
    print "Installing packer close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
  autocmd!
  " autocmd BufWritePost init.lua source <afile> | PackerSync
  " autocmd BufWritePost general.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
    return
end

-- Have packer use a popup window
packer.init {
    display = {
        open_fn = function()
            return require("packer.util").float { border = "rounded" }
        end,
        working_sym = '', -- The symbol for a plugin being installed/updated
        error_sym = '✗',   -- The symbol for a plugin with an error in installation/updating
        done_sym = '✓',    -- The symbol for a plugin which has completed installation/updating
        removed_sym = '-', -- The symbol for an unused plugin which was removed
        moved_sym = '→',   -- The symbol for a plugin which was moved (e.g. from opt to start)
        header_sym = '━',  -- The symbol for the header line in packer's display
    }
}

-- Install your plugins here
local use = require('packer').use
require('packer').startup(function()
    use "wbthomason/packer.nvim" -- Have packer manage itself
    use ("nathom/filetype.nvim")  -- filetype.nvim - Easily speed up your neovim startup time!
    use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
    use ({ 'nvim-lua/plenary.nvim' })  -- Useful lua functions used by lots of plugins
    use "windwp/nvim-autopairs"  -- Autopairs, integrates with both cmp and treesitter
    use "numToStr/Comment.nvim"  -- Easily comment stuff
    use ({ 'rktjmp/lush.nvim' })       -- color scheme aid plugin
    use ({
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end
    })
    use ({
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true },
        config = [[require('config.lualine')]],
    })
    use ({
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = [[require('config.treesitter')]],
    })
    -- LSP
    -- use "neovim/nvim-lspconfig"           -- Enable LSP
    -- use "williamboman/nvim-lsp-installer" -- Simple to use language server installer
    -- use "tamago324/nlsp-settings.nvim"    -- language server settings in json
    -- use "jose-elias-alvarez/null-ls.nvim" -- For formatters and linters
    -- use ({ 'folke/lsp-colors.nvim' })           -- Auto add missing colour group for LSP
    -- use ({ 'nvim-lua/lsp_extensions.nvim' })    -- Extentions for built-in LSP, e.g. inlay hints
    use ({
        'neovim/nvim-lspconfig',
        requires = {
            'williamboman/nvim-lsp-installer',
            'tamago324/nlsp-settings.nvim',
            'jose-elias-alvarez/null-ls.nvim',
            'folke/lsp-colors.nvim',
            'nvim-lua/lsp_extensions.nvim',
        },
        config = [[require('config.lsp')]],
    })

    -- https://github.com/ray-x/lsp_signature.nvim
    use "ray-x/lsp_signature.nvim"

    -- nvim-cmp
    use ({
        "hrsh7th/nvim-cmp",
        requires = {
            -- https://github.com/quangnguyen30192/cmp-nvim-ultisnips
            -- "quangnguyen30192/cmp-nvim-ultisnips",
            "quangnguyen30192/cmp-nvim-tags",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lsp-signature-help",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-calc",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-look",
            'hrsh7th/cmp-cmdline',
            "ray-x/cmp-treesitter",
            "f3fora/cmp-spell",
            "hrsh7th/cmp-emoji",
        },
        config = [[require('config.cmp')]],
    })
    -- snippets - ultisnip
    -- use "honza/vim-snippets"
    -- use ({
    --     "SirVer/ultisnips",
    --     requires = "honza/vim-snippets",
    --     config = function()
    --         vim.g.UltiSnipsRemoveSelectModeMappings = 0
    --     end,
    -- })
    -- use "quangnguyen30192/cmp-nvim-ultisnips"
    -- For luasnip user.
    use ({ 'rafamadriz/friendly-snippets' })
    use ({
        "L3MON4D3/LuaSnip",
        requires = { "rafamadriz/friendly-snippets" },
        -- config = function()
        --   require("luasnip.loaders.from_vscode").lazy_load()
        -- end,
        config = [[require('config.luasnip')]],
    })
    use "saadparwaiz1/cmp_luasnip"

    use ({ 'p00f/clangd_extensions.nvim' })
    use ({ 'cuducos/yaml.nvim' })

    -- FZF setup
    use ({
        'junegunn/fzf',
        dir = '~/.fzf',
        run = { './install --all' },
    })
    use ({
        'junegunn/fzf.vim',
        -- Adding the config here and not requiring at the end, break telescope-ui-select
        config = [[require('config.fzf')]],
    })

    -- Telescope https://github.com/nvim-telescope/telescope.nvim
    use ({'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
    use ({
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        },
        config = [[require('config.telescope')]],
    })
    use ({ 'nvim-telescope/telescope-ui-select.nvim' })

    -- Vim/Neovim plugins
    -- use ({ 'antenore/vim-safe' })          -- Not compatible with neovim
    use ({ 'chrisbra/csv.vim' })
    use ({ 'ludovicchabant/vim-gutentags' })
    --use ({ 'majutsushi/tagbar' })
    -- vista.vim: A tagbar alternative that supports LSP symbols and async processing
    use ({
        "liuchengxu/vista.vim",
        config = function()
            vim.g.vista_default_executive = "nvim_lsp"
            nnoremap { "<F8>", ":Vista!!<CR>" }
        end,
    })
    -- use ({ 'godlygeek/tabular' })             -- Needed by vim-markdown (and me :- )
    -- Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
    -- related works: godlygeek/tabular
    use ({
        "junegunn/vim-easy-align",
        config = function()
            -- Start interactive EasyAlign for a motion/text object (e.g. gaip)
            nmap { "ga", "<Plug>(EasyAlign)" }
            -- Start interactive EasyAlign in visual mode (e.g. vipga)
            xmap { "ga", "<Plug>(EasyAlign)" }
            -- Align GitHub-flavored Markdown tables
            -- https://thoughtbot.com/blog/align-github-flavored-markdown-tables-in-vim
            vmap { "<Leader><Bslash>", ":EasyAlign*<Bar><Enter>" }
        end,
    })
    use ({ 'mboughaba/i3config.vim' })
    use ({ 'nvie/vim-flake8' })               -- Python style guide
    use ({ 'relastle/vim-nayvy' })            -- Enriching python coding.
    use ({
        'ixru/nvim-markdown',
        config = [[require('config.vim-markdown')]],
    })

    use ({ 'rodjek/vim-puppet' })
    use ({ 'puppetlabs/puppet-syntax-vim' })
    --use ({ 'scrooloose/nerdtree' })
    use ({
        "kyazdani42/nvim-tree.lua",
        config = [[require('config.nvim-tree')]],
        requires = { "kyazdani42/nvim-web-devicons" },
    })

    -- Git
    use ({ 'tpope/vim-fugitive' })            -- :G*
    use ({
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function() require("gitsigns").setup() end
    })
    use ({ 'tpope/vim-rhubarb' })
    -- https://github.com/glepnir/indent-guides.nvim
    use ({
        "glepnir/indent-guides.nvim",
        config = [[require('config.indent-guides')]],
    })
    use ({ 'tpope/vim-surround' })
    use ({ 'tmux-plugins/vim-tmux' })
    use ({ 'wincent/command-t' })
    use ({ 'ryanoasis/vim-devicons' })
    use ({ 'PProvost/vim-ps1' })
    use ({ 'https://gitlab.com/antenore/Luciano.git' })
    use ({ '/home/antenore/software/myvim/plugins/mdview.nvim' })
    -- use ({ '/home/antenore/software/myvim/plugins/jaflpl.nvim' })
    use ({
        'mcchrish/zenbones.nvim',
        requires = { 'rktjmp/lush.nvim', opt = true },
        config = [[
            vim.g.zenbones_darkness = "warm"
            vim.g.zenbones_lightness = "dim"
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd('colorscheme tokyobones')
        ]]
    })

    use ({ 'ewilazarus/preto' })
    use ({
        'luochen1990/rainbow',
        config = [[require('config.rainbow')]],
    })
    use ({ 'lervag/vimtex' })
    use ({ 'neomake/neomake', cmd = 'Neomake' })
    use ({
        'jbyuki/venn.nvim',
        config = [[require('config.venn')]],
    })
    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

require('config.fzf')
require('config.nerdtree')
-- require('config.vim-markdown')
require('config.neomake')
-- require('config.ultisnip')
require('config.vimsafe')       -- Disabled
-- require('config.rainbow')
require('config.vimtex')
-- require('config.treesitter')
-- require('config.lsp')
-- require('config.cmp')
-- require('config.lualine')
-- require('config.telescope')
require('config.gutentags')
require('config.tagbar')

-- }}}
-- {{{ ===== Jaflpl.nvim ========================================================
-- require'jaflpl'.setup({})
-- }}}
-- {{{ ===== Empty Entry ========================================================
-- }}}
