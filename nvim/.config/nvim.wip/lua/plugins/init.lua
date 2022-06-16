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
  autocmd BufWritePost plugins.lua source <afile> | PackerSync
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
    use "nvim-lua/popup.nvim"    -- An implementation of the Popup API from vim in Neovim
    use 'nvim-lua/plenary.nvim'  -- Useful lua functions used by lots of plugins
    use "windwp/nvim-autopairs"  -- Autopairs, integrates with both cmp and treesitter
    use "numToStr/Comment.nvim"  -- Easily comment stuff
    use 'rktjmp/lush.nvim'       -- color scheme aid plugin
    use {
        "kyazdani42/nvim-web-devicons",
        config = function()
            require("nvim-web-devicons").setup()
        end
    }
    use {
        "nvim-lualine/lualine.nvim",
        requires = { "kyazdani42/nvim-web-devicons", opt = true }
    }
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }
    -- LSP
    use "neovim/nvim-lspconfig"           -- Enable LSP
    use "williamboman/nvim-lsp-installer" -- Simple to use language server installer
    use "tamago324/nlsp-settings.nvim"    -- language server settings in json
    use "jose-elias-alvarez/null-ls.nvim" -- For formatters and linters
    use 'folke/lsp-colors.nvim'           -- Auto add missing colour group for LSP
    use 'nvim-lua/lsp_extensions.nvim'    -- Extentions for built-in LSP, e.g. inlay hints
    -- nvim-cmp
    use {
        "hrsh7th/nvim-cmp",
        requires = {
            -- https://github.com/quangnguyen30192/cmp-nvim-ultisnips
            "quangnguyen30192/cmp-nvim-ultisnips",
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
    }
    -- snippets - ultisnip
    use "honza/vim-snippets"
    use({
        "SirVer/ultisnips",
        requires = "honza/vim-snippets",
        config = function()
            vim.g.UltiSnipsRemoveSelectModeMappings = 0
        end,
    })
    use "quangnguyen30192/cmp-nvim-ultisnips"

    use 'p00f/clangd_extensions.nvim'
    use 'cuducos/yaml.nvim'

    -- FZF setup
    use {
        'junegunn/fzf',
        dir = '~/.fzf',
        run = { './install --all' },
    }
    use 'junegunn/fzf.vim'

    -- Telescope https://github.com/nvim-telescope/telescope.nvim
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            {'nvim-lua/plenary.nvim'},
            {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        }
    }
    use 'nvim-telescope/telescope-ui-select.nvim'

    -- Vim/Neovim plugins
    -- use 'antenore/vim-safe'          -- Not compatible with neovim
    use 'chrisbra/csv.vim'
    use 'ludovicchabant/vim-gutentags'
    use 'majutsushi/tagbar'
    use 'godlygeek/tabular'             -- Needed by vim-markdown (and me :- )
    use 'mboughaba/i3config.vim'
    use 'nvie/vim-flake8'               -- Python style guide
    use 'relastle/vim-nayvy'            -- Enriching python coding.
    use 'plasticboy/vim-markdown'       -- Needs tabular
    use 'rodjek/vim-puppet'
    use 'puppetlabs/puppet-syntax-vim'
    use 'scrooloose/nerdtree'
                                        -- Git
    use 'tpope/vim-fugitive'            -- :G*
    use {
        "lewis6991/gitsigns.nvim",
        requires = { "nvim-lua/plenary.nvim" },
        config = function() require("gitsigns").setup() end
    }
    use 'tpope/vim-rhubarb'
    use 'tpope/vim-surround'
    use 'tmux-plugins/vim-tmux'
    use 'wincent/command-t'
    use 'ryanoasis/vim-devicons'
    use 'PProvost/vim-ps1'
    use 'https://gitlab.com/antenore/Luciano.git'      -- Hey it's me!!
    use '/home/antenore/software/myvim/plugins/mdview.nvim'
    -- use '/home/antenore/software/myvim/plugins/jaflpl.nvim'
    use {
        'mcchrish/zenbones.nvim',
        requires = { 'rktjmp/lush.nvim', opt = true },
        config = [[
            vim.g.zenbones_darkness = "warm"
            vim.g.zenbones_lightness = "dim"
            vim.opt.termguicolors = true
            vim.opt.background = "dark"
            vim.cmd('colorscheme tokyobones')
        ]]
    }

    use 'ewilazarus/preto'
    use 'luochen1990/rainbow'
    use 'lervag/vimtex'
    use { 'neomake/neomake', cmd = 'Neomake' }
    -- Automatically set up your configuration after cloning packer.nvim
    if PACKER_BOOTSTRAP then
        require("packer").sync()
    end
end)

require('plugins.config.fzf')
require('plugins.config.nerdtree')
require('plugins.config.vim-markdown')
require('plugins.config.neomake')
require('plugins.config.ultisnip')
require('plugins.config.vimsafe')       -- Disabled
require('plugins.config.rainbow')
require('plugins.config.vimtex')
require('plugins.config.treesitter')
require('plugins.config.lsp')
require('plugins.config.cmp')
require('plugins.config.lualine')
require('plugins.config.telescope')
require('plugins.config.gutentags')
require('plugins.config.tagbar')

-- }}}
-- {{{ ===== Jaflpl.nvim ========================================================
-- require'jaflpl'.setup({})
-- }}}
-- {{{ ===== Empty Entry ========================================================
-- }}}
