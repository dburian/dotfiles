-- Configuration of nvim-compe

local lspkind = require'lspkind'
local luasnip = require'luasnip'

vim.opt.completeopt = "menuone,noselect"

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
    ['<C-d>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<leader>e'] = cmp.mapping.close(),
    ['<c-j>'] = cmp.mapping.select_next_item(),
    ['<c-k>'] = cmp.mapping.select_prev_item(),
    ['<c-l>'] = cmp.mapping(function (fallback)
      if luasnip.expand_or_jumpable() then
        return luasnip.expand_or_jump()
      elseif cmp.visible() then
        return cmp.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        })
      end

      fallback()
    end, {'i', 'c'}),
    ['<c-h>'] = cmp.mapping(function (fallback)
      if luasnip.jumpable(-1) then
        return luasnip.jump(-1)
      end

      fallback()
    end, {'i', 'c'}),
    -- ['<c-l>'] = cmp.mapping.confirm {
    --   behavior = cmp.ConfirmBehavior.Replace,
    --   select = true,
    -- },
    -- ['<Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   else
    --     fallback()
    --   end
    -- end,
    -- ['<S-Tab>'] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
    { name = 'path' },
    { name = 'buffer'}
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        nvim_lua = "[api]",
        path = "[path]",
        luasnip = "[snip]",
      },
    },
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  }
}

-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })

-- `:` cmdline setup.
-- cmp.setup.cmdline(':', {
--   sources = cmp.config.sources({
--     { name = 'path' }
--   }, {
--     { name = 'cmdline' }
--   })
-- })