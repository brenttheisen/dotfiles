-- 1. SET LEADER FIRST (Must be before any mappings or plugins)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Load core settings and keymaps
require("options")
require("keymaps")

-- 4. Initialize plugins
require("lazy").setup({
  -- Colorscheme
  { "maxmx03/solarized.nvim", priority = 1000, config = function()
    vim.cmd.colorscheme("solarized")
  end },

  -- UI
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, config = true },
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", config = true },
  { "nvim-tree/nvim-tree.lua", config = true },
  { "folke/trouble.nvim", opts = {} },

  -- Fuzzy Finding
  { 
    "nvim-telescope/telescope.nvim", 
    lazy = false, -- Load immediately
    dependencies = { "nvim-lua/plenary.nvim" }, 
    config = function()
      require("telescope").setup({})
    end
  },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Git
  "tpope/vim-fugitive",
  { "lewis6991/gitsigns.nvim", config = true },

  -- LSP
  { "neovim/nvim-lspconfig" },
  { "hrsh7th/nvim-cmp", dependencies = { "hrsh7th/cmp-nvim-lsp", "L3MON4D3/LuaSnip" } },

  -- Utilities
  "vimpostor/vim-lumen",
})
