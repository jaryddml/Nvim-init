--Hello world
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

local nvim_lsp = require('lspconfig')

-- Set up Pyright for Python LSP
nvim_lsp.pyright.setup{
    on_attach = on_attach,
    flags = {
        debounce_text_changes = 150,
    }
}

-- Customize diagnostic symbols in the sign column (gutter)
local signs = { Error = "✘ ", Warn = "⚠ ", Hint = "⚑ ", Info = "ℹ " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

-- Show diagnostics automatically
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, show diagnostics only on the current line
    virtual_text = {
      spacing = 4,
      prefix = '●'
    },
    -- Use a function to determine whether to show hint diagnostics
    severity_sort = true,
    update_in_insert = true,  -- Update diagnostics insert mode
  }
)

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

-- Further LSP configurations or other setups can follow here


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

--keybindings

-- Save with Ctrl+S in Normal and Insert modes
vim.api.nvim_set_keymap('n', '<C-s>', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<C-s>', '<C-c>:w<CR>', { noremap = true, silent = true })

-- Exit with Ctrl+X in Normal mode 
vim.api.nvim_set_keymap('n', '<C-x>', ':qa<CR>', { noremap = true, silent = true })

