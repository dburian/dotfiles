
local m = {}

function m.on_attach(_, bufnr)
  local opts = {noremap = true, silent = true}

  local bfk = function(mode, lhs, rhs) vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts) end
  -- local bfo = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Native completion filled by lsp
  -- bfo('omnifunc', 'v:vim.lua.lsp.omnifunc')

  bfk('n', '<leader>lgd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  bfk('n', '<leader>lgr', '<cmd>lua vim.lsp.buf.references()<CR>')
  bfk('n', '<leader>lgi', '<cmd>lua vim.lsp.buf.implementation()<CR>')

  bfk('n', '<leader>lh', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  bfk('i', '<leader>lh', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  bfk('n', '<leader>lr', '<cmd>lua vim.lsp.buf.rename()<CR>')
  bfk('n', '<leader>lc', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  bfk('n', '<leader>l[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  bfk('n', '<leader>l]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  bfk('n', '<leader>ld', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  bfk('n', '<leader>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>')
end

return m
