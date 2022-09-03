local keymap = require('user.lib.keys').keymap
local nvim_lsp = require('lspconfig')
local servers = { 'clangd' }
local opts = { noremap = true, silent = true }
keymap('n', '<space>E', vim.diagnostic.open_float, opts)
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<space>q', vim.diagnostic.setloclist, opts)

local on_attach = function(client, bufnr)
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
  keymap('n', 'gD', vim.lsp.buf.declaration, bufopts); 
  keymap('n', 'K', vim.lsp.buf.hover, bufopts)
  keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  keymap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  keymap('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  keymap('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  keymap('n', '<space>rn', vim.lsp.buf.rename, bufopts)
  keymap('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  keymap('n', 'gr', vim.lsp.buf.references, bufopts)
  keymap('n', '<space>F', function()
    vim.lsp.buf.format({ async = true })
  end, bufopts)

end

for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach
  }
end

