local M = {}

function M.nmap(opts)
  vim.keymap.set('n', opts[1], opts[2], opts[3])
end

function M.imap(opts)
  vim.keymap.set('i', opts[1], opts[2], opts[3])
end

function M.vmap(opts)
  vim.keymap.set('v', opts[1], opts[2], opts[3])
end

function M.smap(opts)
  vim.keymap.set('s', opts[1], opts[2], opts[3])
end

return M
