-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/antenore/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/antenore/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/antenore/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/antenore/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/antenore/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["Comment.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/Comment.nvim",
    url = "https://github.com/numToStr/Comment.nvim"
  },
  LuaSnip = {
    config = { "require('config.luasnip')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["alpha-nvim"] = {
    config = { "\27LJ\2\n`\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\2B\0\2\1K\0\1\0\vconfig\26alpha.themes.startify\nsetup\nalpha\frequire\0" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/alpha-nvim",
    url = "https://github.com/goolord/alpha-nvim"
  },
  ["clangd_extensions.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/clangd_extensions.nvim",
    url = "https://github.com/p00f/clangd_extensions.nvim"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-calc"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-calc",
    url = "https://github.com/hrsh7th/cmp-calc"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-emoji"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-emoji",
    url = "https://github.com/hrsh7th/cmp-emoji"
  },
  ["cmp-look"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-look",
    url = "https://github.com/hrsh7th/cmp-look"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-nvim-lua"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-nvim-lua",
    url = "https://github.com/hrsh7th/cmp-nvim-lua"
  },
  ["cmp-nvim-tags"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-nvim-tags",
    url = "https://github.com/quangnguyen30192/cmp-nvim-tags"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  ["cmp-spell"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-spell",
    url = "https://github.com/f3fora/cmp-spell"
  },
  ["cmp-treesitter"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp-treesitter",
    url = "https://github.com/ray-x/cmp-treesitter"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["csv.vim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/csv.vim",
    url = "https://github.com/chrisbra/csv.vim"
  },
  ["filetype.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/filetype.nvim",
    url = "https://github.com/nathom/filetype.nvim"
  },
  ["friendly-snippets"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/friendly-snippets",
    url = "https://github.com/rafamadriz/friendly-snippets"
  },
  fzf = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/fzf",
    url = "https://github.com/junegunn/fzf"
  },
  ["fzf.vim"] = {
    config = { "require('config.fzf')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/fzf.vim",
    url = "https://github.com/junegunn/fzf.vim"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["i3config.vim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/i3config.vim",
    url = "https://github.com/mboughaba/i3config.vim"
  },
  ["impatient.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/impatient.nvim",
    url = "https://github.com/lewis6991/impatient.nvim"
  },
  ["indent-guides.nvim"] = {
    config = { "require('config.indent-guides')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/indent-guides.nvim",
    url = "https://github.com/glepnir/indent-guides.nvim"
  },
  ["lsp-colors.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/lsp-colors.nvim",
    url = "https://github.com/folke/lsp-colors.nvim"
  },
  ["lsp_extensions.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/lsp_extensions.nvim",
    url = "https://github.com/nvim-lua/lsp_extensions.nvim"
  },
  ["lsp_signature.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/lsp_signature.nvim",
    url = "https://github.com/ray-x/lsp_signature.nvim"
  },
  ["lualine.nvim"] = {
    config = { "require('config.lualine')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["lush.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/lush.nvim",
    url = "https://github.com/rktjmp/lush.nvim"
  },
  ["mdview.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/mdview.nvim",
    url = "/home/antenore/software/myvim/plugins/mdview.nvim"
  },
  neomake = {
    commands = { "Neomake" },
    loaded = false,
    needs_bufread = false,
    only_cond = false,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/opt/neomake",
    url = "https://github.com/neomake/neomake"
  },
  ["nlsp-settings.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nlsp-settings.nvim",
    url = "https://github.com/tamago324/nlsp-settings.nvim"
  },
  ["null-ls.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/null-ls.nvim",
    url = "https://github.com/jose-elias-alvarez/null-ls.nvim"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-cmp"] = {
    config = { "require('config.cmp')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-colorizer.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nvim-colorizer.lua",
    url = "https://github.com/norcalli/nvim-colorizer.lua"
  },
  ["nvim-lsp-installer"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nvim-lsp-installer",
    url = "https://github.com/williamboman/nvim-lsp-installer"
  },
  ["nvim-lspconfig"] = {
    config = { "require('config.lsp')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-markdown"] = {
    config = { "require('config.vim-markdown')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nvim-markdown",
    url = "https://github.com/ixru/nvim-markdown"
  },
  ["nvim-tree.lua"] = {
    config = { "require('config.nvim-tree')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "require('config.treesitter')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    config = { "\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["puppet-syntax-vim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/puppet-syntax-vim",
    url = "https://github.com/puppetlabs/puppet-syntax-vim"
  },
  rainbow = {
    config = { "require('config.rainbow')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/rainbow",
    url = "https://github.com/luochen1990/rainbow"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-symbols.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/telescope-symbols.nvim",
    url = "https://github.com/nvim-telescope/telescope-symbols.nvim"
  },
  ["telescope-ui-select.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/telescope-ui-select.nvim",
    url = "https://github.com/nvim-telescope/telescope-ui-select.nvim"
  },
  ["telescope.nvim"] = {
    config = { "require('config.telescope')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["venn.nvim"] = {
    config = { "require('config.venn')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/venn.nvim",
    url = "https://github.com/jbyuki/venn.nvim"
  },
  ["vim-devicons"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vim-devicons",
    url = "https://github.com/ryanoasis/vim-devicons"
  },
  ["vim-easy-align"] = {
    config = { "\27LJ\2\nù\1\0\0\3\0\6\0\n6\0\0\0005\2\1\0B\0\2\0016\0\2\0005\2\3\0B\0\2\0016\0\4\0005\2\5\0B\0\2\1K\0\1\0\1\3\0\0\21<Leader><Bslash>\28:EasyAlign*<Bar><Enter>\tvmap\1\3\0\0\aga\22<Plug>(EasyAlign)\txmap\1\3\0\0\aga\22<Plug>(EasyAlign)\tnmap\0" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vim-easy-align",
    url = "https://github.com/junegunn/vim-easy-align"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-gutentags"] = {
    config = { "require('config.gutentags')" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vim-gutentags",
    url = "https://github.com/ludovicchabant/vim-gutentags"
  },
  ["vim-ps1"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vim-ps1",
    url = "https://github.com/PProvost/vim-ps1"
  },
  ["vim-puppet"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vim-puppet",
    url = "https://github.com/rodjek/vim-puppet"
  },
  ["vim-rhubarb"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vim-rhubarb",
    url = "https://github.com/tpope/vim-rhubarb"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-tmux"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vim-tmux",
    url = "https://github.com/tmux-plugins/vim-tmux"
  },
  vimtex = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vimtex",
    url = "https://github.com/lervag/vimtex"
  },
  ["vista.vim"] = {
    config = { "\27LJ\2\nm\0\0\3\0\6\0\b6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0005\2\5\0B\0\2\1K\0\1\0\1\3\0\0\t<F8>\17:Vista!!<CR>\rnnoremap\rnvim_lsp\28vista_default_executive\6g\bvim\0" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/vista.vim",
    url = "https://github.com/liuchengxu/vista.vim"
  },
  ["yaml.nvim"] = {
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/yaml.nvim",
    url = "https://github.com/cuducos/yaml.nvim"
  },
  ["zenbones.nvim"] = {
    config = { "\t\t\t\t\t\tvim.g.zenbones_darkness = \"warm\"\n\t\t\t\t\t\tvim.g.zenbones_lightness = \"dim\"\n\t\t\t\t\t\tvim.opt.termguicolors = true\n\t\t\t\t\t\tvim.opt.background = \"dark\"\n\t\t\t\t\t\tvim.cmd('colorscheme tokyobones')\n\t\t" },
    loaded = true,
    path = "/home/antenore/.local/share/nvim/site/pack/packer/start/zenbones.nvim",
    url = "https://github.com/mcchrish/zenbones.nvim"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
require('config.nvim-tree')
time([[Config for nvim-tree.lua]], false)
-- Config for: venn.nvim
time([[Config for venn.nvim]], true)
require('config.venn')
time([[Config for venn.nvim]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
require('config.treesitter')
time([[Config for nvim-treesitter]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
require('config.telescope')
time([[Config for telescope.nvim]], false)
-- Config for: lualine.nvim
time([[Config for lualine.nvim]], true)
require('config.lualine')
time([[Config for lualine.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
require('config.lsp')
time([[Config for nvim-lspconfig]], false)
-- Config for: nvim-colorizer.lua
time([[Config for nvim-colorizer.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14colorizer\frequire\0", "config", "nvim-colorizer.lua")
time([[Config for nvim-colorizer.lua]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
require('config.cmp')
time([[Config for nvim-cmp]], false)
-- Config for: rainbow
time([[Config for rainbow]], true)
require('config.rainbow')
time([[Config for rainbow]], false)
-- Config for: indent-guides.nvim
time([[Config for indent-guides.nvim]], true)
require('config.indent-guides')
time([[Config for indent-guides.nvim]], false)
-- Config for: alpha-nvim
time([[Config for alpha-nvim]], true)
try_loadstring("\27LJ\2\n`\0\0\5\0\5\0\n6\0\0\0'\2\1\0B\0\2\0029\0\2\0006\2\0\0'\4\3\0B\2\2\0029\2\4\2B\0\2\1K\0\1\0\vconfig\26alpha.themes.startify\nsetup\nalpha\frequire\0", "config", "alpha-nvim")
time([[Config for alpha-nvim]], false)
-- Config for: nvim-web-devicons
time([[Config for nvim-web-devicons]], true)
try_loadstring("\27LJ\2\n?\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\22nvim-web-devicons\frequire\0", "config", "nvim-web-devicons")
time([[Config for nvim-web-devicons]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
require('config.luasnip')
time([[Config for LuaSnip]], false)
-- Config for: vista.vim
time([[Config for vista.vim]], true)
try_loadstring("\27LJ\2\nm\0\0\3\0\6\0\b6\0\0\0009\0\1\0'\1\3\0=\1\2\0006\0\4\0005\2\5\0B\0\2\1K\0\1\0\1\3\0\0\t<F8>\17:Vista!!<CR>\rnnoremap\rnvim_lsp\28vista_default_executive\6g\bvim\0", "config", "vista.vim")
time([[Config for vista.vim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\n6\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\rgitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: zenbones.nvim
time([[Config for zenbones.nvim]], true)
						vim.g.zenbones_darkness = "warm"
						vim.g.zenbones_lightness = "dim"
						vim.opt.termguicolors = true
						vim.opt.background = "dark"
						vim.cmd('colorscheme tokyobones')
		
time([[Config for zenbones.nvim]], false)
-- Config for: vim-easy-align
time([[Config for vim-easy-align]], true)
try_loadstring("\27LJ\2\nù\1\0\0\3\0\6\0\n6\0\0\0005\2\1\0B\0\2\0016\0\2\0005\2\3\0B\0\2\0016\0\4\0005\2\5\0B\0\2\1K\0\1\0\1\3\0\0\21<Leader><Bslash>\28:EasyAlign*<Bar><Enter>\tvmap\1\3\0\0\aga\22<Plug>(EasyAlign)\txmap\1\3\0\0\aga\22<Plug>(EasyAlign)\tnmap\0", "config", "vim-easy-align")
time([[Config for vim-easy-align]], false)
-- Config for: vim-gutentags
time([[Config for vim-gutentags]], true)
require('config.gutentags')
time([[Config for vim-gutentags]], false)
-- Config for: fzf.vim
time([[Config for fzf.vim]], true)
require('config.fzf')
time([[Config for fzf.vim]], false)
-- Config for: nvim-markdown
time([[Config for nvim-markdown]], true)
require('config.vim-markdown')
time([[Config for nvim-markdown]], false)

-- Command lazy-loads
time([[Defining lazy-load commands]], true)
pcall(vim.cmd, [[command -nargs=* -range -bang -complete=file Neomake lua require("packer.load")({'neomake'}, { cmd = "Neomake", l1 = <line1>, l2 = <line2>, bang = <q-bang>, args = <q-args>, mods = "<mods>" }, _G.packer_plugins)]])
time([[Defining lazy-load commands]], false)

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
