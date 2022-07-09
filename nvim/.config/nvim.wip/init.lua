--
--  ███╗   ██╗  | My init.lua file.
--  ████╗  ██║  | You can use it at your own risk, before to ask question RTFM.
--  ██╔██╗ ██║  | To quit this file type :q
--  ██║╚██╗██║  | WTFPL (The Do What The Fuck You Want To Public License)
--  ██║ ╚████║  | Antenore (tmow) Gatta - WTFPL License
--  ╚═╝  ╚═══╝  | - https://antenore.simbiosi.org
--
--  ===== Before everything else ===============================================
vim.g.did_load_filetypes = 1 -- No default filetype.vim (nathom/filetype.nvim)
vim.g.mapleader = ','
vim.g.maplocalleader = ','
-- ===== Modules ===============================================================
local modules = {
  'utils',
  'general',
  'impatient',               -- Comment this if you remove impatient
  'plugins',
}

for _, module in ipairs(modules) do
  local ok, err = pcall(require, module)
  if not ok then
    error('Error loading ' .. module .. '\n\n' .. err)
  end
  err = nil
end
--  ===== Mapping ==============================================================
vim.cmd [[autocmd BufWritePost general.lua source <afile> | PackerSync]]
vim.cmd [[autocmd BufWritePost plugins.lua source <afile> | PackerSync]]
-- ================================== EOF ======================================
-- vim:set ts=2 sts=2 sw=2 expandtab:
