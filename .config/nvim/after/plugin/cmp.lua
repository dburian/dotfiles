-- Configuration of nvim-compe

local lspkind = require 'lspkind'
local luasnip = require 'luasnip'

vim.opt.completeopt = "menuone,noselect"
vim.opt.tags = 'tags'


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
    ['<c-l>'] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }, { "i", "c" }),
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-p>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    { name = 'tags' },
    { name = 'path' },
    { name = 'buffer' },
    { name = 'emoji' },
    -- { name = 'markdown-link',
    --   option = {
    --     reference_link_location = 'top',
    --     searched_depth = 4,
    --     searched_dirs = { '~/docs/notes', '%:p:h' }
    --   }
    -- },
  },
  formatting = {
    format = lspkind.cmp_format {
      with_text = true,
      menu = {
        buffer = "[buf]",
        nvim_lsp = "[lsp]",
        nvim_lua = "[api]",
        tags = "[tag]",
        path = "[path]",
        luasnip = "[snip]",
        ['markdown-link'] = '[link]'
      },
    },
  },
  experimental = {
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
