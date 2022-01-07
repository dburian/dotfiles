
local m = {}

function m.on_attach(_, bufnr)
  local opts = {noremap = true, silent = true}

  local bfk = function(mode, lhs, rhs) vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts) end
  -- local bfo = function(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Native completion filled by lsp
  -- bfo('omnifunc', 'v:vim.lua.lsp.omnifunc')

  bfk('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
  bfk('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>')
  bfk('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')

  bfk('n', '<leader>h', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  bfk('i', '<leader>h', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  bfk('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  bfk('n', '<leader>ca', "<cmd>lua require'telescope.builtin'.lsp_code_actions()<cr>")
  bfk('n', '<leader>fs', "<cmd>lua require'telescope.builtin'.lsp_document_symbols()<cr>")

  bfk('n', '<leader>[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  bfk('n', '<leader>]d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  bfk('n', '<leader>dl', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>')
  bfk('n', '<leader>fo', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>')
end

return m
