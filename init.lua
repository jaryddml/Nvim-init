-- Specify where plugins start being loaded
vim.cmd('packadd packer.nvim')
require('packer').startup(function()
  -- Plugins list
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  use 'kyazdani42/nvim-tree.lua'
  use 'ellisonleao/gruvbox.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate'  -- Automatically update Tree-sitter grammar on plugin install or update
  }

  -- Add dependencies of nvim-cmp
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
end)

-- Gruvbox color scheme settings
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

-- Nvim-tree setup
require('nvim-tree').setup({
  view = {
    side = 'left',
    width = 30
  }
})

-- Toggle Nvim-tree with F2
vim.api.nvim_set_keymap('n', '<F2>', ':NvimTreeToggle<CR>', {noremap = true})
-- Tree-sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all" or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,              -- Enable tree-sitter based indentation
  }
}



-- Basic Neovim settings
vim.opt.number = true        -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.wrap = false         -- Do not wrap lines
vim.opt.tabstop = 4          -- Number of spaces tabs count for
vim.opt.shiftwidth = 4       -- Size of an indent
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10



-- Completion setup
local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }
})

-- LSP settings
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
require'lspconfig'.pyright.setup{
  on_attach = function(client, bufnr)
    -- Additional client settings can be configured here
    client.resolved_capabilities.document_formatting = false
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()),
  settings = {
    python = {
      analysis = {
        typeCheckingMode = "strict",  -- More detailed type checks for better information
      }
    }
  }
}

[jay@nixos:~]$ nvim ~/.config/nvim/init.lua 

[jay@nixos:~]$ nvim ~/.config/nvim/init.lua 

[jay@nixos:~]$ cat ~/.config/nvim/init.lua 
-- Specify where plugins start being loaded
vim.cmd('packadd packer.nvim')
require('packer').startup(function()
  -- Plugins list
  use 'wbthomason/packer.nvim'
  use 'kyazdani42/nvim-web-devicons' -- for file icons
  use 'kyazdani42/nvim-tree.lua'
  use 'ellisonleao/gruvbox.nvim'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp'
  use {
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate'  -- Automatically update Tree-sitter grammar on plugin install or update
  }

  -- Add dependencies of nvim-cmp
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/cmp-nvim-lua'
end)

-- Gruvbox color scheme settings
require("gruvbox").setup({
  terminal_colors = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "hard", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colorscheme gruvbox")

-- Nvim-tree setup
require('nvim-tree').setup({
  view = {
    side = 'left',
    width = 30
  }
})

-- Toggle Nvim-tree with F2
vim.api.nvim_set_keymap('n', '<F2>', ':NvimTreeToggle<CR>', {noremap = true})
-- Tree-sitter
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all" or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false,
  },
  indent = {
    enable = true,              -- Enable tree-sitter based indentation
  }
}

-- Define on_attach function for LSP
local function on_attach(client, bufnr)
  if client.supports_method("textDocument/semanticTokens/full") then
    vim.api.nvim_buf_attach(bufnr, false, {
      on_lines = function()
        vim.lsp.buf.semantic_tokens_full()
      end
    })
  end
  -- Here you can also define other buffer-local settings,
  -- keybindings, or functionality to enable upon attaching the LSP.
end

-- Define on_attach function for LSP
local function on_attach(client, bufnr)
  if client.supports_method("textDocument/semanticTokens/full") then
    vim.api.nvim_buf_attach(bufnr, false, {
      on_lines = function()
        vim.lsp.buf.semantic_tokens_full()
      end
    })
  end
  -- Here you can also define other buffer-local settings,
  -- keybindings, or functionality to enable upon attaching the LSP.
end

-- Completion setup
local cmp = require('cmp')
cmp.setup({
  mapping = {
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
  }
})

-- Basic Neovim settings
vim.opt.number = true        -- Show line numbers
vim.opt.relativenumber = false -- Show relative line numbers
vim.opt.wrap = false         -- Do not wrap lines
vim.opt.tabstop = 4          -- Number of spaces tabs count for
vim.opt.shiftwidth = 4       -- Size of an indent
vim.opt.expandtab = true     -- Use spaces instead of tabs
vim.opt.clipboard = 'unnamedplus'
vim.opt.mouse = 'a'
vim.opt.undofile = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.updatetime = 250
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.inccommand = 'split'
vim.opt.cursorline = true
vim.opt.scrolloff = 10
