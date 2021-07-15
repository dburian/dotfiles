
local m = {}


function m.on_attach(_, bufnr)
  local opts = {noremap = true, silent = true}

  local bfk = function(mode, lhs, rhs) vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts) end
  local bfo = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Native completion filled by lsp
  bfo('omnifunc', 'v:vim.lua.lsp.omnifunc')

  bfk('i', '<leader>c', '<c-x><c-o>')

  bfk('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  bfk('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  bfk('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')

  bfk('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  -- bfk('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  bfk('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  bfk('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  bfk('n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  bfk('n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  bfk('n', '<leader>dl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  bfk('n', '<leader>p', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

return m
