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
  use("nathom/filetype.nvim")  -- filetype.nvim - Easily speed up your neovim startup time!
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
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = [[require('plugins.config.lualine')]],
  }
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = [[require('plugins.config.treesitter')]],
  })
  -- LSP
  -- use "neovim/nvim-lspconfig"           -- Enable LSP
  -- use "williamboman/nvim-lsp-installer" -- Simple to use language server installer
  -- use "tamago324/nlsp-settings.nvim"    -- language server settings in json
  -- use "jose-elias-alvarez/null-ls.nvim" -- For formatters and linters
  -- use 'folke/lsp-colors.nvim'           -- Auto add missing colour group for LSP
  -- use 'nvim-lua/lsp_extensions.nvim'    -- Extentions for built-in LSP, e.g. inlay hints
  use({
    'neovim/nvim-lspconfig',
    requires = {
      'williamboman/nvim-lsp-installer',
      'tamago324/nlsp-settings.nvim',
      'jose-elias-alvarez/null-ls.nvim',
      'folke/lsp-colors.nvim',
      'nvim-lua/lsp_extensions.nvim',
    },
    config = [[require('plugins.config.lsp')]],
  })

  -- nvim-cmp
  use {
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
    config = [[require('plugins.config.cmp')]],
  }
  -- snippets - ultisnip
  -- use "honza/vim-snippets"
  -- use({
  --     "SirVer/ultisnips",
  --     requires = "honza/vim-snippets",
  --     config = function()
  --         vim.g.UltiSnipsRemoveSelectModeMappings = 0
  --     end,
  -- })
  -- use "quangnguyen30192/cmp-nvim-ultisnips"
  -- For luasnip user.
  use { "rafamadriz/friendly-snippets" }
  use {
    "L3MON4D3/LuaSnip",
    requires = { "rafamadriz/friendly-snippets" },
    -- config = function()
    --   require("luasnip.loaders.from_vscode").lazy_load()
    -- end,
    config = [[require('plugins.config.luasnip')]],
  }
  use "saadparwaiz1/cmp_luasnip"

  use 'p00f/clangd_extensions.nvim'
  use 'cuducos/yaml.nvim'

  -- FZF setup
  use {
    'junegunn/fzf',
    dir = '~/.fzf',
    run = { './install --all' },
  }
  use({
    'junegunn/fzf.vim',
    config = [[require('plugins.config.fzf')]],
  })

  -- Telescope https://github.com/nvim-telescope/telescope.nvim
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {
      {'nvim-lua/plenary.nvim'},
      {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
    },
    config = [[require('plugins.config.telescope')]],
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
  use ({
    'ixru/nvim-markdown',
    config = [[require('plugins.config.vim-markdown')]],
  })

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
  use({
    'luochen1990/rainbow',
    config = [[require('plugins.config.rainbow')]],
  })
  use 'lervag/vimtex'
  use { 'neomake/neomake', cmd = 'Neomake' }
  -- Automatically set up your configuration after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

require('plugins.config.fzf')
require('plugins.config.nerdtree')
-- require('plugins.config.vim-markdown')
require('plugins.config.neomake')
-- require('plugins.config.ultisnip')
require('plugins.config.vimsafe')       -- Disabled
-- require('plugins.config.rainbow')
require('plugins.config.vimtex')
-- require('plugins.config.treesitter')
-- require('plugins.config.lsp')
-- require('plugins.config.cmp')
-- require('plugins.config.lualine')
-- require('plugins.config.telescope')
require('plugins.config.gutentags')
require('plugins.config.tagbar')

-- }}}
-- {{{ ===== Jaflpl.nvim ========================================================
-- require'jaflpl'.setup({})
-- }}}
-- {{{ ===== Empty Entry ========================================================
-- }}}
