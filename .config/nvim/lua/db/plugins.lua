local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'

  -- Verbs
  use 'https://github.com/tpope/vim-surround'
  use 'https://github.com/tpope/vim-commentary'
  use 'https://github.com/inkarkat/vim-ReplaceWithRegister'
  use 'https://github.com/easymotion/vim-easymotion'

  -- Repeat whole plugin maps
  use 'tpope/vim-repeat'

  -- Objects/nouns
  use 'https://github.com/michaeljsmith/vim-indent-object'

  -- Git
  use 'https://github.com/tpope/vim-fugitive'

  -- Project drawer
  use 'tpope/vim-vinegar'

  -- Telescope
  use 'nvim-lua/popup.nvim'
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-file-browser.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'dburian/telescope-markdown-links'
  use 'nvim-telescope/telescope-ui-select.nvim'

  -- LSP
  use 'neovim/nvim-lspconfig'
  use 'jose-elias-alvarez/null-ls.nvim'

  -- Treesitter
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use 'nvim-treesitter/nvim-treesitter-context' -- display context in first line

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-buffer'
  use 'saadparwaiz1/cmp_luasnip'
  use 'dburian/cmp-markdown-link'
  use 'quangnguyen30192/cmp-nvim-tags'

  use 'onsails/lspkind-nvim' -- nice icons in autocomplete menu

  -- Snippets
  use 'L3MON4D3/LuaSnip'

  -- Status line
  use 'nvim-lualine/lualine.nvim'

  use 'jpalardy/vim-slime'



  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
