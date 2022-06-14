--
--  ███╗   ██╗  | My init.lua file.
--  ████╗  ██║  | You can use it at your own risk, before to ask question RTFM.
--  ██╔██╗ ██║  | To quit this file type :q
--  ██║╚██╗██║  | WTFPL (The Do What The Fuck You Want To Public License)
--  ██║ ╚████║  | Antenore (tmow) Gatta - WTFPL License
--  ╚═╝  ╚═══╝  | - https://antenore.simbiosi.org
--
-- {{{ ===== Before everything else ============================================
HOME = os.getenv("HOME")
vim.opt.foldenable = true
vim.opt.foldmethod = 'marker'
-- }}}
-- {{{ ===== Modules ===========================================================
local modules = {
  "setup",
  "plugins",
  "core",
  "latex"
}
for _, module in ipairs(modules) do
   local ok, err = pcall(require, module)
   if not ok then
      error("Error loading " .. module .. "\n\n" .. err)
   end
end
-- }}}
-- ====================================== EOF =========================================
-- vim:set ts=2 sts=2 sw=2 expandtab:
