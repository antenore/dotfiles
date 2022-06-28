-- {{{ ===== lsp-colors.nvim ====================================================
require("lsp-colors").setup({})
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

