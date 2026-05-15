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

  -- Startup screen
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      dashboard.section.header.val = {
        "                                                     ",
        "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
        "                                                     ",
      }

      dashboard.section.buttons.val = {
        dashboard.button("e", "  New file",        ":ene <BAR> startinsert <CR>"),
        dashboard.button("f", "  Find file",       ":Telescope find_files<CR>"),
        dashboard.button("r", "  Recent files",    ":Telescope oldfiles<CR>"),
        dashboard.button("g", "  Find text",       ":Telescope live_grep<CR>"),
        dashboard.button("q", "  Quit",            ":qa<CR>"),
      }

      alpha.setup(dashboard.config)
    end,
  },

  -- UI
  { "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons" }, opts = {
    sections = {
      lualine_c = { { "filename", path = 1 } },
    },
  }},
  { "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", config = true },
  { "nvim-tree/nvim-tree.lua", config = true },
  { "folke/trouble.nvim", opts = {} },

  -- Fuzzy Finding
  { 
    "nvim-telescope/telescope.nvim", 
    lazy = false, -- Load immediately
    dependencies = { "nvim-lua/plenary.nvim" }, 
    config = function()
      require("telescope").setup({
        pickers = {
          find_files = {
            hidden = true,
            file_ignore_patterns = { ".git/" },
          },
        },
      })
    end
  },

  -- Treesitter
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },

  -- Git
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  { "lewis6991/gitsigns.nvim", config = true },

  -- LSP
  {
    "williamboman/mason.nvim",
    config = true
  },
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "bashls", "lua_ls", "vtsls" },
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shfmt",
        "prettier",
        "shellcheck",
      },
    },
  },
  { 
    "neovim/nvim-lspconfig",
    config = function()
      -- Use the new Neovim 0.11+ API if available
      if vim.lsp.config then
        -- Set global capabilities for nvim-cmp
        local capabilities = {}
        if pcall(require, "cmp_nvim_lsp") then
          capabilities = require("cmp_nvim_lsp").default_capabilities()
        end
        vim.lsp.config('*', { capabilities = capabilities })

        -- Configure specific servers
        vim.lsp.config('lua_ls', {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } }
            }
          }
        })

        vim.lsp.config('vtsls', {
          settings = {
            typescript = {
              updateImportsOnFileMove = { enabled = "always" },
              suggest = { completeFunctionCalls = true },
            },
          },
        })

        -- Enable servers
        vim.lsp.enable('bashls')
        vim.lsp.enable('lua_ls')
        vim.lsp.enable('vtsls')
      else
        -- Fallback for Neovim < 0.11
        local lspconfig = require("lspconfig")
        lspconfig.bashls.setup({})
        lspconfig.lua_ls.setup({
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } }
            }
          }
        })
        lspconfig.vtsls.setup({})
      end
    end
  },
  {
    "Exafunction/codeium.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
    config = true,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"]     = cmp.mapping.scroll_docs(-4),
          ["<C-f>"]     = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"]     = cmp.mapping.abort(),
          ["<CR>"]      = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
            else fallback() end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then luasnip.jump(-1)
            else fallback() end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "codeium" },
          { name = "luasnip" },
        }),
      })
    end,
  },

  -- Utilities
  "vimpostor/vim-lumen",
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        sh = { "shfmt" },
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
    },
  },
})
